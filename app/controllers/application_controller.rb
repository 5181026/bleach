class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authorize_user , except: [:login , :add_user]  #フィルターでアクションの処理の前にauthorize_userを処理する

  protected
  #ログインしていないユーザをloginに戻す
  def authorize_user
    unless session[:user].present?
        redirect_to action: "login"
    end
  end
end
