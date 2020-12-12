class FavoritesController < ApplicationController
  before_action:required_logged_in
  
  def create
    post = Post.find(params[:favorite][:post_id])
    current_user.favorite(post)
    flash[:success] = '投稿をいいねしました。'
    redirect_to top_url
  end

  def destroy
    post = Post.find(params[:favorite][:post_id])
    current_user.unfavorite(post)
    flash[:success] = 'いいねを外しました。'
    redirect_to top_url
  end
end
