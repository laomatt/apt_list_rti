class LunchGroupUsersController < ApplicationController
  before_action :set_lunch_group_user, only: [:show, :edit, :update, :destroy]

  # GET /lunch_group_users
  # GET /lunch_group_users.json
  def index
    @lunch_group_users = LunchGroupUser.all
  end

  # GET /lunch_group_users/1
  # GET /lunch_group_users/1.json
  def show
  end

  # GET /lunch_group_users/new
  def new
    @lunch_group_user = LunchGroupUser.new
  end

  # GET /lunch_group_users/1/edit
  def edit
  end

  # POST /lunch_group_users
  # POST /lunch_group_users.json
  def create
    @lunch_group_user = LunchGroupUser.new(lunch_group_user_params)

    respond_to do |format|
      if @lunch_group_user.save
        format.html { redirect_to @lunch_group_user, notice: 'Lunch group user was successfully created.' }
        format.json { render :show, status: :created, location: @lunch_group_user }
      else
        format.html { render :new }
        format.json { render json: @lunch_group_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lunch_group_users/1
  # PATCH/PUT /lunch_group_users/1.json
  def update
    
  end

  # DELETE /lunch_group_users/1
  # DELETE /lunch_group_users/1.json
  def destroy
    # TODO: people can be kicked out of grops

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lunch_group_user
      @lunch_group_user = LunchGroupUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lunch_group_user_params
      params.fetch(:lunch_group_user, {})
    end
end
