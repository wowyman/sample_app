class CommentsController < ApplicationController
  load_and_authorize_resource

  def index
    @comments = @micropost.comments.hash_tree
  end

  def new
    @comment = @micropost.comments.new(post_parent_id: params[:post_parent_id])
  end

  def edit; end

  def create
    # if params[:comment][:post_parent_id].to_i > 0
    #   parent = @micropost.comments.find_by_id(params[:comment].delete(:post_parent_id))
    #   @comment = parent.children.build(commentParams)
    # else

    # end
    @comment = @micropost.comments.new(commentParams)
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Comment successfully added"
      redirect_to comments_path(@comment)
    else
      render "new"
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def destroy
    @comment.destroy
  end

  private

  def commentParams
    params.require(:comment).permit(:body, :post_parent_id)
  end
end
