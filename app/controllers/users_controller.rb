class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update, :followings, :followers]

  def index
    @users = User.order(id: :asc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
    @post = current_user.posts.build
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
    @user=User.find(params[:id])
    
    if current_user == @user
      if @user.update(user_params)
        flash[:success] = 'ユーザー情報を更新しました。'
        redirect_to @user
      else
        flash.now[:danger] = 'ユーザー情報の編集に失敗しました。'
        render :edit
      end
    else
      redirect_to root_url
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
  end
  
  def likes
    @user = User.find(params[:id])
    @favorites = @user.favorited_posts.page(params[:page])
    @post = current_user.posts.build
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
