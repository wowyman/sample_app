# frozen_string_literal: true

class MicropostsController < ApplicationController
  load_and_authorize_resource

  def create
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render "static_pages/home"
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
end
