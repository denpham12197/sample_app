class PasswordResetsController < ApplicationController
  before_action :load_user, :valid_user, :check_expiration,
    only: [:edit, :update]

  def new; end

  def edit; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "message.msg5"
      redirect_to root_url
    else
      flash.now[:danger] = t "errors.error1"
      render :new
    end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, t("errors.error2"))
      render :edit
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = t "message.msg6"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def load_user
    @user = User.find_by email: params[:email]
    return if @user
    flash[:danger] = t "errors.nil_user"
    redirect_to root_path
  end

  def valid_user
    unless @user&.activated? &&
           @user.authenticated?(:reset, params[:id])
      redirect_to root_url
    end
  end

  def check_expiration
    return false unless @user.password_reset_expired?
    flash[:danger] = t "message.msg7"
    redirect_to new_password_reset_path
  end
end
