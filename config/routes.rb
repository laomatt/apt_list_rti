Rails.application.routes.draw do
  devise_for :users
  resources :lunch_group_users
  resources :lunch_groups do 
  	collection do 
  		get 'start_lunch'
    end

    member do 
      get 'get_partial'
    end
  end


  resources :users do 
  	collection do 
  		post 'manual_create'
  		post 'manual_login'
  	end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#login'
end
