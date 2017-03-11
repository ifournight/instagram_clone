class UsersController < ApplicationController
  # HOOKS
  before_action :set_user, only: [:show]

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        UserMailer.user_activate(@user, @user.activation_token).deliver_later
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /users/follow
  def follow
    to_follow = User.find(params[:followed_id])
    if current_user.not_following?(to_follow)
      current_user.follow(to_follow)
      @user = to_follow.reload
      redirect_to "/#{to_follow.name}"
    else
      user.errors[:base] << "already follow user #{to_follow.name}"
      redirect_to request.referer || "/#{to_follow.name}"
    end
  end

  # DELETE /users/follow
  def unfollow
    to_unfollow = User.find(params[:followed_id])
    if current_user.following?(to_unfollow)
      current_user.unfollow(to_unfollow)
      redirect_to "/#{to_unfollow.name}"
    else
      user.errors[:base] << "can't unfollow if not following #{to_unfollow.name}"
      redirect_to request.referer || "/#{to_unfollow.name}"
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(name: params[:name])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :website, :intro, :password, :password_confirmation)
    end
end
