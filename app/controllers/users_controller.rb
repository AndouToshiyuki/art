class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update]

  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
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
  
  def edit
    @user = User.find(params[:id])
    
    if @user != current_user
      redirect_to @user
    end
  end
  
  def update
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
