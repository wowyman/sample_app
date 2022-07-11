# frozen_string_literal: true

# aaa
class StaticPagesController < ApplicationController
  def home
    return unless user_signed_in?

    @micropost = current_user.microposts.build
    @feed_items = current_user.feed.paginate(page: params[:page])
  end

  def help; end

  def about; end

  def contact; end
end
