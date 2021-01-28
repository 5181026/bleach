class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authorize_user , except: [:login , :add_user]  #フィルターでアクションの処理の前にauthorize_userを処理する

rescue_from ActiveRecord::RecordNotFound, with: :authentication_error_handler
  def authentication_error_handler
    flash[:alert] = Constants::W_002
    redirect_to controller:  :user , action: :login
  end

  protected
  #ログインしていないユーザをloginに戻す
  def authorize_user
    unless session[:user].present?
        redirect_to controller:  :user , action: :login
    end
  end
end
