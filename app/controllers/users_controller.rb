class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :show, :create]
  before_action :load_user, except: [:new, :index, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def new
    @user = User.new
  end

  def show
    redirect_to root_url && return unless @user.activated
    @microposts = @user.microposts.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = t "errors.check_email"
      redirect_to root_url
    else
      render :new
    end
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "errors.profile_update"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "errors.user_deleted"
      redirect_to users_path
    else
      flash[:danger] = t "errors.nil_user"
      redirect_to root_path
    end
  end

  def following
    @title = t "message.msg12"
    @users = @user.following.paginate(page: params[:page])
    render "show_follow"
  end

  def followers
    @title = t "message.msg13"
    @users = @user.followers.paginate(page: params[:page])
    render "show_follow"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "errors.pls_login"
    redirect_to login_path
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_path unless current_user? @user
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "errors.nil_user"
    redirect_to root_path
  end
end
