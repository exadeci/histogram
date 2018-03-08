class PageViewsController < ApplicationController

  def histogram
    arguments = PageViewValidation.new(page_view_params)

    if arguments.valid?
      render json: repo.find(arguments)
    else
      render json: {error: arguments}, status: 422
    end
  end

  private

  def page_view_params
    params.require(:page_view).permit(:before, :after, :interval, urls: [])
  end

  def repo
    @repo ||= PageViewRepository.new
  end
end
