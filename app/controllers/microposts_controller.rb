# frozen_string_literal: true

class MicropostsController < ApplicationController
  load_and_authorize_resource :micropost
  load_and_authorize_resource :comment
  after_create :create_user_interactive

  def create
    @micropost.image.attach(params[:micropost][:image])
    respond_to do |format|
      if @micropost.save
        format.html { redirect_to root_url, notice: "Micropost created!" }
      else
        @feed_items = current_user.feed.paginate(page: params[:page])
        format.html { render "static_pages/home", status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    if request.referer.nil? || request.referer == microposts_url
      redirect_to root_url
    else
      redirect_to request.referer
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :image)
  end

  def create_user_interactive
    current_user.user_interactives.create
  end
end
