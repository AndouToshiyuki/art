class PostsController < ApplicationController
before_action :require_user_logged_in
before_action :correct_user, only: [:destroy]

  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      flash[:success] = 'よくできました❀'
      redirect_to '/top'
    else
      @posts =Post.all.sort {|a,b| b.favorites.count <=> a.favorites.count}
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
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to 'users/show'
    end
  end
end
