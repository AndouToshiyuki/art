class TagsController < ApplicationController
  before_action :required_logged_in
  
  def index
    @search = Tag.ransack(params[:q])
    @results = @search.result(distinct: true)
  end
  
  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.order(favorites_count: :desc).page(params[:page])
  end
end
