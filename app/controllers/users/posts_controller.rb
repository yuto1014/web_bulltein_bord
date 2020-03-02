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
  	   @categories = Category.order(created_at: :desc).limit(20)
  end

  def show
  	   @post = Post.find(params[:id])
  	   @comment = Comment.new
       @comments = @post.comments
  end

   def search
       @posts = Post.where('title LIKE(?)', "%#{params[:search]}%").order(created_at: :desc)
       @comments = Comment.where('content LIKE(?)', "%#{params[:search]}%").order(created_at: :desc)
       x = []
       @posts.each do |post|
          x << post.id
       end
       y = []
       @comments.each do |comment|
          y << comment.post.id
       end
       z = x << y
       search_posts = []
       z.uniq.map do |search_post|
          search_posts << search_post
       end
       @search_posts = Post.where(id: search_posts)
       @search_result = "#{params[:search]}"
       @categories = Category.order(created_at: :desc).limit(20)
    end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :user_id, :category_post_id)
  end

end
