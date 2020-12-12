class PostsController < ApplicationController
  before_action :required_logged_in
  before_action :current_user_posts, only: [:destroy]

  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      flash[:success] = 'よくできました❀'
      redirect_to top_url
    else
      @posts =Post.all.order(favorites_count: :desc).page(params[:page])
      flash.now[:danger] = '文字数が多すぎます。'
      render 'posting/index'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_back(fallback_location: top_path)
  end

  private
  
  def post_params
    params.require(:post).permit(:content,:image)
  end
  
  def current_user_posts
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to 'users/show'
    end
  end
end
