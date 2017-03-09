class UsersController < ApplicationController
  # HOOKS
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
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

  # POST /users/follow
  def follow
    to_follow = User.find(params[:followed_id])
    if current_user.not_following?(to_follow)
      current_user.follow(to_follow)
      @user = to_follow.reload
      redirect_to "/#{to_follow.id}"
    else
      user.errors[:base] << "already follow user #{to_follow.id}"
      redirect_to request.referer || "/#{to_follow.id}"
    end
  end

  # DELETE /users/follow
  def unfollow
    to_unfollow = User.find(params[:followed_id])
    if current_user.following?(to_unfollow)
      current_user.unfollow(to_unfollow)
      redirect_to "/#{to_unfollow.id}"
    else
      user.errors[:base] << "can't unfollow if not following #{to_unfollow.id}"
      redirect_to request.referer || "/#{to_unfollow.id}"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :website, :intro, :password, :password_confirmation)
    end
end
