class Users::PostsController < ApplicationController

  def new
  	@post = Post.new
  end

  def create
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      categories  = @post.body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
      categories.uniq.map do |category|
        category = Category.find_or_create_by(name: category.downcase.delete('#'))
        category.save
        @post.categories << category
      end
      if @post.save
         redirect_to users_posts_path
      else
         render :new
      end
  end

  def index
  	@posts = Post.order(created_at: :desc)
  	@categories = Category.order(created_at: :desc).limit(8)
  end

  def show
  	@post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :user_id, :category_post_id)
  end

end
