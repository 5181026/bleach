class UserController < ApplicationController
    # ユーザ登録のコントローラ
    def create_user
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

        puts session[:user].user_name
    end
end
