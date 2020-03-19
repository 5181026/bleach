class UserController < ApplicationController
    @@use_case = UserUseCase.new
    
    # ユーザ登録のコントローラ
    def add_user
        @header_title = Constants::ADD_USER_TITLE;
        user_name = params[:user_name]
        user_id = params[:user_id]
        user_pass = params[:user_pass]
        re_pass = params[:re_pass]

        @@use_case.create_account(user_name , user_id , user_pass , re_pass) if user_name.present?
        
    end

    def notification
    end
    
    # ログインのコントローラ
    def login_user
    end

    # ユーザ編集のコントローラ
    def edit_user
    end

    #プロフィール表示のコントローラ
    def mypage_view 
        #############テスト用##############
        session[:user] = UserUseCase.new.auth()
        ###################################

        # puts session[:user].friends[1][:messageid]
        puts session[:user].friends.select { |str| str[:friendid] == "test002"}
    end
end
