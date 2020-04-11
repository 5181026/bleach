class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authorize_user , except: [:login , :add_user]  #フィルターでアクションの処理の前にauthorize_userを処理する

  # class FireBase < ActionController::ActionControllerError
  # end 

  # rescue_from FireBase, with: :firebase_not_connection
  
  # def firebase_not_connection
  #   puts "接続に失敗しました"
  # end

  protected
  #ログインしていないユーザをloginに戻す
  def authorize_user
    unless session[:user].present?
        redirect_to action: :login
    end
  end
end
