class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [ :show]

  def show
    @user = User.find(params[:id])
    @user.image_name= "/user_images/default_user.jpg"
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.image_name= "/user_images/default_user.jpg"

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to '/top'
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
