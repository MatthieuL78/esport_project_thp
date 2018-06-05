Rails.application.routes.draw do
<<<<<<< HEAD
  root 'home#index'
=======
  mount ForestLiana::Engine => '/forest'
  devise_for :sponsors
  devise_for :players
>>>>>>> 0fedf36c7c2924803af2eaa21f2df8407d0c4c70
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
