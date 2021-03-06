Rails.application.routes.draw do
 # 管理者側deviseルーティング
  devise_for :admin, skip: :all
   devise_scope :admin do
     get "/admin/sign_in", to: "admin/sessions#new", as: :new_admin_session
     post "/admin/sign_in", to: "admin/sessions#create", as: :admin_session
     delete "/admin/sign_out", to: "admin/sessions#destroy", as: :destroy_admin_session
   end
# メンバー側deviseルーティング
  devise_for :members, skip: :all
   devise_scope :member do
     get "/members/sign_up", to: "public/registrations#new", as: :new_member_registration
     post "/members", to: "public/registrations#create", as: :member_registration
     get "/members/sign_in", to: "public/sessions#new", as: :new_member_session
     post "/members/sign_in", to: "public/sessions#create", as: :member_session
     delete "/members/sign_out", to: "public/sessions#destroy", as: :destroy_member_session
     post '/members/guest_sign_in', to: 'public/sessions#guest_sign_in'
   end
# メンバー側ルーティング
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
    resources :posts,only:[:index,:show,:create,:destroy,:new] do
     patch "/close", to: "posts#close", as: :close
     resources :comments,only:[:create,:destroy]
     resource :favorites,only:[:create,:destroy]
    end
    resources :games,only:[:index,:show]
    get "/search", to: "games#search",as: :search
    resources :chats,only:[:show,:create]
    resources :contacts,only:[:new,:create]
    post "/contacts/confirm",to: "contacts#confirm", as: :confirm
    post "/contacts/back",to: "contacts#back", as: :back
    get "/done",to: "contacts#done", as: :done
    resources :notifications,only:[:index], as: :notifications
    resources :announcements,only:[:index,:show]
  end
# 管理者側ルーティング
  namespace :admin do
   resources :games
   resources :announcements,only:[:new,:create,:edit,:update,:destroy]
   resources :members,only:[:index] do
     patch "/close", to: "members#close"
   end
  end

end
