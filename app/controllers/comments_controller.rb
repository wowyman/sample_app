class CommentsController < ApplicationController
  include ActionView::RecordIdentifier
  include CommentsHelper
  before_action :set_current_user
  before_action :authenticate_user!
  load_and_authorize_resource :micropost
  load_and_authorize_resource :comment
  after_create :create_user_interactive

  def new
    @comment = Comment.new
    @parent = Comment.find_by(id: params[:post_parent_id])
  end

  def edit
  end

  def create
    @comment = @micropost.comments.new(comment_params)
    @comment.user = current_user
    @comment.image.attach(params[:comment][:image])
    respond_to do |format|
      if @comment.save
        format.turbo_stream { }
        format.html { redirect_to root_url }
        format.json { render :show, status: :created, location: @comment }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(dom_id_for_records(@micropost, @comment), partial: "comments/form",
                                                                                              locals: { micropost: @micropost, comment: @comment })
        }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
  end

  def create_user_interactive
    current_user.user_interactives.create
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_parent_id, :micropost, :user, :image)
  end

  def set_current_user
    @current_user = current_user
  end
end
