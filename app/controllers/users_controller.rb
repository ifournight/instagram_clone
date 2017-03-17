class UsersController < ApplicationController
  # HOOKS
  before_action :set_user, only: [:show, :followers, :following]
  before_action :set_current_user, only: [:edit, :update]
  skip_before_action :authenticate_user!, only: [:show]

  # GET /users/1
  # GET /users/1.json
  def show
  end

  def edit
  end

  def update
    @user.update_attributes(user_params)
    @user.save

    respond_to do |format|
      if @user.save
        format.html { redirect_to request.referer || root_url, notice: 'User was successfully updated.' }
        format.json { render :update, status: :updated, location: @user }
      else
        format.html { render :edit }
        # format.json { render json: @user.errors, status: :}
      end
    end
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
      redirect_to request.referer || "/#{to_follow.name}"
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
      redirect_to request.referer || "/#{to_unfollow.name}"
    else
      user.errors[:base] << "can't unfollow if not following #{to_unfollow.name}"
      redirect_to request.referer || "/#{to_unfollow.name}"
    end
  end

  def like
    @post = Post.find(params[:post_id])
    @user = User.find(params[:id])

    if @user.like?(@post)
      @user.errors[:base] << "repeat like."
    else
      @user.like(@post)
      @user = @user.reload
    end

    redirect_to request.referer || root_url
  end

  def unlike
    @post = Post.find(params[:post_id])
    @user = User.find(params[:id])

    if @user.like?(@post)
      @user.unlike(@post)
      @user = @user.reload
    else
      @user.errors[:base] << "repeat unlike."
    end

    redirect_to request.referer || root_url
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(name: params[:name])
    end

    # set current signed in user to @user
    def set_current_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :website, :intro, :password, :password_confirmation)
    end
end
