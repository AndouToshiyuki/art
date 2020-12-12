class ToppagesController < ApplicationController
  before_action :required_logged_in
  
  def index
    if logged_in?
      @post = current_user.posts.build  # form_with 用
      @posts = @posts =Post.all.order(favorites_count: :desc).page(params[:page])
    end
  end
end
