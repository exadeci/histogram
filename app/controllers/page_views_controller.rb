class PageViewsController < ApplicationController

  def histogram
    render json: repo.find(urls: [], before: '', after: '', interval: '')
  end

  private

  def page_view_params
    params.require(:page_view).permit(:urls, :before, :after, :interval)
  end

  def repo
    @repo ||= PageViewRepository.new
  end
end