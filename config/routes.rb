Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :page_views do
    collection do
      post :histogram
    end
  end
end
