class Users::CategoriesController < ApplicationController

  def new
	#cocoonで親子同時保存
	@category = Category.new
	@category.posts.build
  end

  def create
  	@category = Category.new(category_params)
  	if @category.save
        redirect_to users_posts_path
	  else
		    render :new
	  end
  end


  private
  def category_params
  	params.require(:category).permit(:name, posts_attributes: [:id, :title, :body, :image, :category_id, :user_id])
  end

end
