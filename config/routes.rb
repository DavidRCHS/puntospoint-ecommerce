PuntospointEcommerce::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      match 'auth/login', to: 'auth#login', via: :post

      resources :products, only: [:index, :show, :create, :update] do
        collection do
          get :most_purchased, to: 'products#most_purchased'
          get :top_revenue, to: 'products#top_revenue'
        end
      end

      resources :purchases, only: [:index, :show, :create] do
        collection do
          get :count_by_granularity, to: 'purchases#count_by_granularity'
        end
      end

      resources :versions, only: [:index]

      resources :categories, only: [:index]
    end
  end
end