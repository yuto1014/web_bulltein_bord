class Users::CommentsController < ApplicationController

	def create
      @post = Post.find(params[:post_id])
      #投稿に紐づいたコメントを作成
      @comment = @post.comments.build(comment_params)
      @comment.user_id = current_user.id
      comments  = @comment.content.scan(/>>[\d+]+/)
      comments.uniq.map do |comment|
        comment = Comment.find_or_create_by(content: comment.downcase.delete('>>'))
        comment.save
      end
      if @comment.save
      	render :index
      end
    end

    def destroy
      @comment = Comment.find(params[:id])
      if @comment.destroy
      	render :index
      end
    end

    private
    def comment_params
      params.require(:comment).permit(:content, :post_id, :user_id, :reply)
    end

end
