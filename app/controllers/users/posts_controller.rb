class Users::PostsController < ApplicationController

  def index
  	@posts = Post.order(created_at: :desc)
  	@categories = Category.order(created_at: :desc).limit(8)
  end

  def show
  	@post = Post.find(params[:id])
  end

end
