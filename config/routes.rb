Rails.application.routes.draw do
  devise_for :admin, skip: :all
   devise_scope :admin do
     get "/admin/sign_in", to: "admin/sessions#new", as: :new_admin_session
     post "/admin/sign_in", to: "admin/sessions#create", as: :admin_session
     delete "/admin/sign_out", to: "admin/sessions#destroy", as: :destroy_admin_session
   end

  devise_for :members, skip: :all
   devise_scope :member do
     get "/members/sign_up", to: "public/registrations#new", as: :new_member_registration
     post "/members", to: "public/registrations#create", as: :member_registration
     get "/members/sign_in", to: "public/sessions#new", as: :new_member_session
     post "/members/sign_in", to: "public/sessions#create", as: :member_session
     delete "/members/sign_out", to: "public/sessions#destroy", as: :destroy_member_session
   end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: :public do
    root :to => "homes#top"
    get "/about" => "homes#about"
    resources :members,only:[:show,:edit,:update] do
     resource :playing_games,only:[:create,:destroy]
     get "/playing_games/index", to: "playing_games#index", as: :playing_games_index
     resource :relationships,only:[:create,:destroy]
     get "/relationships/followings",to: "relationships#followings", as: :followings_index
     get "/relationships/followers",to: "relationships#followers", as: :followers_index
    end
    resources :posts,only:[:index,:show,:create,:destroy] do
     resources :comments,only:[:create,:destroy]
    end
    resources :games,only:[:index,:show]
    resources :chats,only:[:show,:create]
  end

  namespace :admin do
   resources :games
  end

end
