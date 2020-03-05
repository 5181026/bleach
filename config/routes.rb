Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/group_view" , to: "group#group_view"
  get "/group_search" , to: "group#group_search"
  get "/group_info" , to: "group#group_info_view"
  get "/message" , to: "message#chat"

  post "/group_view" , to: "group#group_view"
end
