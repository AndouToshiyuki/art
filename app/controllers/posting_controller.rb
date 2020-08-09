class PostingController < ApplicationController
before_action :require_user_logged_in
   
  def index
    
    if logged_in?
      @post = current_user.posts.build  # form_with 用
    end
  end
end
