Rails.application.routes.draw do



  resources :appointments


  resources :families

  
  get 'welcome/index'
  get 'home', to: 'home#index', as: 'home'

  devise_for :users
  
  # root to: "welcome#index"

  devise_scope :user do
    authenticated :user do
      root to: 'welcome#index', as: :user_authenticated_root
    end
    unauthenticated :user do
      root :to => 'devise/registrations#new', as: :user_unauthenticated_root
    end   
  end

  devise_for :dietitians

  devise_scope :dietitian do
    authenticated :dietitian do
      # root :to => 'recipes#dietitian_recipes_index', :constraints => lambda { |request| request.env['warden'].user.class.name == 'Dietitian' }, :as => "dietitian_authenticated_root"
      root :to => 'recipes#dietitian_recipes_index', as: :dietitian_authenticated_root
      resources :characteristics
      resources :ingredients_recipes
      resources :allergens_ingredients
      resources :recipes_patient_groups
      resources :recipe_steps
      resources :ingredients
      resources :ingredients
      resources :allergens
      resources :recipes do
        get :autocomplete_ingredient_name, :on => :collection
      end
    end
    unauthenticated :dietitian do
      root :to => 'devise/registrations#new', as: :dietitian_unauthenticated_root
    end   
  end
  

      # dietitian recipes index page
      get '/recipes/dietitian_recipes_index/:id', to: 'recipes#dietitian_recipes_index', as: 'dietitian_recipes'
      # recipes edit recipe group page
      get '/recipes/edit_recipe_group/:id', to: 'recipes#edit_recipe_group', as: 'edit_recipe_group'




end
