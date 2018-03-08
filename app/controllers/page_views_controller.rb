class PageViewsController < ApplicationController

  def histogram
    arguments = PageViewValidation.new(page_view_params)

    if arguments.valid?
      render json: repo.find(urls: [], before: '', after: '', interval: '')
    else
      render json: {error: arguments}, status: 422
    end
  end

  private

  def page_view_params
    params.require(:page_view).permit(:urls, :before, :after, :interval)
  end

  def repo
    @repo ||= PageViewRepository.new
  end
end
