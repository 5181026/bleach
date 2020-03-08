Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/friend_view" , to: "friend#friend_view"
  get "/friend_info_view" , to: "friend#friend_info_view"
  get "/friend_search" , to: "friend#friend_search"
  get "/group_view" , to: "group#group_view"
  get "/group_search" , to: "group#group_search"
  get "/group_info" , to: "group#group_info_view"
  get "/message" , to: "message#chat"

  post "/friend_view" , to: "friend#friend_view"
  post "/group_view" , to: "group#group_view"
end
