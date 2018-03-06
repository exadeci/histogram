class PageViewsController < ApplicationController

  def histogram

  end

  def page_view_params
    params.require(:page_view).permit(:urls, :before, :after, :interval)
  end

  private

  def repo
    @repo ||= PageViewRepository.new
  end
end