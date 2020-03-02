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
  	   @categories_all = Category.all
       not0 = []
       @categories_all.each do  |category|
        if category.posts.count > 0
          not0 << category.id
        end
      end
      @categories = Category.where(id: not0).order(created_at: :desc).limit(20)
  end

  def show
  	   @post = Post.find(params[:id])
  	   @comment = Comment.new
       @comments = @post.comments
  end

  def search
       @posts = Post.where('title LIKE(?)', "%#{params[:search]}%")
       post_search = []
       @posts.each do |post|
          post_search << post.id
       end
       @comments = Comment.where('content LIKE(?)', "%#{params[:search]}%")
       comment_search = []
       @comments.each do |comment|
          comment_search << comment.post.id
       end
       @search_categories = Category.where('name LIKE(?)', "%#{params[:search]}%")
       category_search_all = []
       @search_categories.each do |search_category|
        category_search_all << search_category.id
       end
       category_search_posts = CategoryPost.where(category_id: category_search_all)
       category_search_select = []
       category_search_posts.each do |category_search_post|
          category_search_select << category_search_post.post_id
       end
       category_search = Post.where(id: category_search_select)
       q = post_search + comment_search + category_search
       search_posts = []
       q.uniq.map do |search_post|
          search_posts << search_post
       end
       @search_posts = Post.where(id: search_posts).order(created_at: :desc)
       @search_result = "#{params[:search]}"
       @categories_all = Category.all
       not0 = []
       @categories_all.each do  |category|
        if category.posts.count > 0
          not0 << category.id
        end
      end
      @categories = Category.where(id: not0).order(created_at: :desc).limit(20)
  end

  def destroy
      post = Post.find(params[:id])
      post.destroy
      redirect_to users_posts_path
  end

  def category
      @category = Category.find(params[:id])
      @category_posts = CategoryPost.where(category_id: @category.id)
      posts = []
      @category_posts.each do |category_posts|
        posts << category_posts.post_id
      end
      @posts = Post.where(id: posts)
      @categories_all = Category.all
       not0 = []
       @categories_all.each do  |category|
        if category.posts.count > 0
          not0 << category.id
        end
      end
      @categories = Category.where(id: not0).order(created_at: :desc).limit(20)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :user_id, :category_post_id)
  end

end
