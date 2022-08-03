# frozen_string_literal: true

class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.all.paginate(page: params[:page])
    date_start = DateTime.now
    date_end = date_start - 1.month
    @microposts = current_user.microposts.where(created_at: date_end..date_start)
    @following_users = current_user.active_relationships.where(created_at: date_end..date_start)
    @followed_users = current_user.passive_relationships.where(created_at: date_end..date_start)
    micropost_csv = ExportCsvService.new(@microposts, Micropost::CSV_ATTRIBUTES, "microposts.csv")
    following_csv = ExportCsvService.new(@following_users, Relationship::CSV_ATTRIBUTES, "following_users.csv", :followed)
    follower_csv = ExportCsvService.new(@followed_users, Relationship::CSV_ATTRIBUTES, "follower_users.csv", :follower)
    respond_to do |format|
      format.zip { send_data ZipService.zip(micropost_csv, following_csv, follower_csv), filename: "export.zip" }
    end
  end

  def new
    @user = User.new
  end

  def show
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    if @user.save
      # handle successful save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = "Please log in."
    redirect_to login_url
  end

  def following
    @title = "Following"
    @users = @user.following.paginate(page: params[:page])
    render "show_follow"
  end

  def followers
    @title = "Followers"
    @users = @user.followers.paginate(page: params[:page])
    render "show_follow"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
