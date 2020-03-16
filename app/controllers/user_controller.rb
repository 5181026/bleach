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

        # puts session[:user].friends[1][:messageid]
        puts session[:user].friends.select { |str| str[:friendid] == "test002"}
    end
end
