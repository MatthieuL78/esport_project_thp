Rails.application.routes.draw do

  root 'home#index'
  get 'rank/index', to: 'rank#index'

  mount ForestLiana::Engine => '/forest'
  devise_for :sponsors
  devise_for :players
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
