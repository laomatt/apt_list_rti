class LunchGroupsController < ApplicationController
  before_action :set_lunch_group, only: [:show, :edit, :update, :destroy, :get_partial]

  # GET /lunch_groups
  # GET /lunch_groups.json
  def index
    @lunch_groups = LunchGroup.current_groups
  end

  # GET /lunch_groups/1
  # GET /lunch_groups/1.json
  def show
  end

  # GET /lunch_groups/new
  def new
    @lunch_group = LunchGroup.new
  end

  # GET /lunch_groups/1/edit
  def edit
  end


  def start_lunch
    # clear current LunchGroupUser table
    LunchGroupUser.destroy_all
    # Sort all current users into groups
    flash[:error] = ''
    User.all.each_slice(4) do |group|
      # IF anyone is eating alone, join them to another group
      if group.size <= 2
        lunch_group = LunchGroup.current_groups.shuffle.first
        #  TODO: fix this to even distribute more than 4 users in group
        while lunch_group.lunch_group_users.count < 5
          lunch_group = LunchGroup.current_groups.shuffle.first
        end
        group.each do |user|
          lunch_group.add_another(user)
        end
      else
        # Make sure group has permanent record of its users
        lunch_group = LunchGroup.new(:users_in_this_group => group.map { |e| e.id }.to_json)
      end

      if lunch_group.save
        group.each do |user|
          join_record = LunchGroupUser.new(:user_id => user.id, :lunch_group_id => lunch_group.id)
          if !join_record.save
            flash[:error] += join_record.errors.full_messages.join(', ')
          end
        end
      end
    end

    # Redirect to index page
    redirect_to lunch_groups_path
  end

  def end_lunch
    # clear out lunch_group_users table
  end

  # POST /lunch_groups
  # POST /lunch_groups.json
  def create
    @lunch_group = LunchGroup.new(lunch_group_params)

    respond_to do |format|
      if @lunch_group.save
        format.html { redirect_to @lunch_group, notice: 'Lunch group was successfully created.' }
        format.json { render :show, status: :created, location: @lunch_group }
      else
        format.html { render :new }
        format.json { render json: @lunch_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lunch_groups/1
  # PATCH/PUT /lunch_groups/1.json
  def update
    # Find the lunch_group_users for this group with the current user
    invite = LunchGroupUser.find_invite(current_user, @lunch_group)
    if invite.nil?
      render :json => { :success => false, :message => 'No such invite', :lunch_group_id => @lunch_group.id }
    else
      case params['this_action']
      when 'confirm'
        invite.confirmed = true
      when 'cancel'
        invite.confirmed = false
      when 'update_location'
        @lunch_group.location = lunch_group_params['type_of_food'] 
        @lunch_group.save       
      end

      if invite.save
        render :json => { :success => true, :message => '', :lunch_group_id => @lunch_group.id }
      else
        render :json => { :success => false, :message => invite.errors.full_messages.join(', '), :lunch_group_id => @lunch_group.id }
      end
    end
  end

  def get_partial
    render :partial => 'lunch_groups/lunch_group_list_item', :locals => { :lunch_group => @lunch_group }
  end

  # DELETE /lunch_groups/1
  # DELETE /lunch_groups/1.json
  def destroy
    @lunch_group.destroy
    respond_to do |format|
      format.html { redirect_to lunch_groups_url, notice: 'Lunch group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lunch_group
      @lunch_group = LunchGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lunch_group_params
      params.require(:lunch_group).permit(:location)
    end
  end
