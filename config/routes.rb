Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "user#login"
  
  get "/add_user" , to: "user#add_user"
  get "/mypage" , to: "user#mypage_view"
  get "/notification" , to: "user#notification"
  get "/friend_view" , to: "friend#friend_view"
  get "/friend_info_view" , to: "friend#friend_info_view"
  get "/friend_search" , to: "friend#friend_search"
  get "/group_view" , to: "group#group_view"
  get "/group_search" , to: "group#group_search"
  get "/group_info" , to: "group#group_info_view"
  get "/message" , to: "message#chat"

  post "/" , to: "user#login"
  post "/add_user" , to: "user#add_user"
  post "/friend_view" , to: "friend#friend_view"
  post "/friend_info_view" , to: "friend#friend_post_notification"
  post "/group_view" , to: "group#group_view"
end
