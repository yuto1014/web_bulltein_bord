class Users::CommentsController < ApplicationController

	  def create
      @post = Post.find(params[:post_id])
      #投稿に紐づいたコメントを作成
      @comment = @post.comments.build(comment_params)
      @comment.user_id = current_user.id
      if @comment.save
        @comment_new = Comment.new
      	render :index
      end
    end

    def destroy
      @comment = Comment.find(params[:id])
      if @comment.destroy
        @post = Post.find(params[:post_id])
        @comment_new = Comment.new
      	render :index
      end
    end

    private
    def comment_params
      params.require(:comment).permit(:content, :post_id, :user_id, :reply)
    end

end
