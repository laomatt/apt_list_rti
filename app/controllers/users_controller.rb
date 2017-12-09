class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @lunch_groups_user_current = @user.current_groups
    @lunch_groups_user_past = @user.find_group_history
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def login
  end

  def manual_login
    user = User.find_by_email(login_params['email'])
    if user && user.valid_password?(login_params['password'])
      sign_in(:user, user)
      redirect_to :back
    else
      flash[:error] = 'Email or password invalid'
      redirect_to :back
    end
  end

  def manual_create
    user = User.new(user_params)
    # byebug
    if (user_params['avatar_url'].nil?) || (user_params['avatar_url'] == '')
      user.avatar_url = Faker::Avatar.image("my-own-slug", "50x50")
    end

    if user.save
      # TODO
      # make a validation code
      # make an entry in the user_holder_table with validation code and 
      # send validation e-mail
      redirect_to user_path(:id => user.id)
    else
      flash[:error] = user.errors.full_messages.join(', ')
      redirect_to :back
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:signup).permit(:name,:email,:avatar_url,:password,:password_confirmation)
  end

  def login_params
    params.require(:login).permit(:email,:password)
  end

  def user_update_params
    params.require(:update).permit(:name,:email,:avatar_url,:payment_info)
  end
end
