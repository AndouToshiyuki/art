class PostsController < ApplicationController
  before_action :required_logged_in
  before_action :current_user_posts, only: [:destroy, :edit, :update]
  
  def create
    @post = current_user.posts.build(post_params)
    @tag_list = params[:post][:tag_name].split("#")
    if @post.save
      @post.save_tag(@tag_list)
      flash[:success] = 'よくできました❀'
      redirect_to top_url
    else
      @posts =Post.all.order(favorites_count: :desc).page(params[:page])
      flash[:danger] = '投稿できませんでした'
      redirect_back(fallback_location: top_path)
    end
  end

  def destroy
    if @post.destroy
      @post.tags.destroy
      flash[:success] = '投稿を削除しました。'
      redirect_back(fallback_location: top_path)
    end
  end
  
  def edit
    @post = Post.find(params[:id])
    @tag_list =@post.tags.pluck(:tag_name).split("#")
  end
  
  def update
    @post = Post.find(params[:id])
    @tag_list = params[:post][:tag_name].split("#")
    if @post.update(post_params)
      @post.save_tag(@tag_list)
      flash[:success] = '投稿を編集しました。'
      redirect_to top_url
    else
      @posts =Post.all.order(favorites_count: :desc).page(params[:page])
      flash.now[:danger] = '投稿できませんでした'
      redirect_to top_url
    end
  end

  private
  
  def post_params
    params.require(:post).permit(:content)
  end
  
  def current_user_posts
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to 'users/show'
    end
  end
end
