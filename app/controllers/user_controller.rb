class UserController < ApplicationController
    @@use_case = UserUseCase.new

    # ログインのアクション
    def login
        @header_title = Constants::USER_LOGIN_TITLE
        if params[:user_id].present?
            user = @@use_case.auth(params[:user_id] , params[:user_pass])
            session[:user] = user
            redirect_to action: :mypage_view
        end
    end

    # ユーザ登録のアクション
    def add_user
        @header_title = Constants::USER_ADD_TITLE;
        user_name = params[:user_name]
        user_id = params[:user_id]
        user_pass = params[:user_pass]
        re_pass = params[:re_pass]
        if @@use_case.create_parameter_confirm?(user_name , user_id , user_pass , re_pass)
            if @@use_case.id_find_user(user_id).present?
                flash[:alert_add_user] = Constants::W_004  
            else
                @@use_case.create_account(user_name , user_id , user_pass , re_pass)
                redirect_to action: :login
            end
        elsif params[:commit].present?
            flash[:alert_add_user] = Constants::W_003
        end
        
    end

    def notification
        gon.user_doc_id = session[:user][Constants::USER_DOC_ID]
        gon.user_id =  session[:user][Constants::USER_ID]
    end

    # ユーザ編集のアクション
    def user_edit
        @header_title = Constants::EDIT_TITLE
        gon.id = session[:user][Constants::USER_ID]
    end

    #プロフィール表示のアクション
    def mypage_view 
        gon.user_id = session[:user][Constants::USER_ID]
    end

    def click_user_edit_button
        session[:user][:user_name] = params[:user_name]
        session[:user][:user_mail] = params[:user_mail]
        session[:user][:user_age] = params[:user_age]
        
        @@use_case.user_parameter_edit(session[:user])
        redirect_to action: :mypage_view
    end

    def logout
        session[:user].clear
        session.delete(:user)
        redirect_to action: :login
    end
end
