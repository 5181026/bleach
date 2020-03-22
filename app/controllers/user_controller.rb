class UserController < ApplicationController
    @@use_case = UserUseCase.new
    #TODO簡単にログインできる（ロジックをしっかり作る）
    # ログインのコントローラ
    def login
        @header_title = "ログインページ"
        if params[:user_id].present?
            user = @@use_case.auth(params[:user_id] , params[:user_pass])
            session[:user] = user
            redirect_to action: "mypage_view"
        end
    end

    # ユーザ登録のコントローラ
    def add_user
        @header_title = Constants::ADD_USER_TITLE;
        user_name = params[:user_name]
        user_id = params[:user_id]
        user_pass = params[:user_pass]
        re_pass = params[:re_pass]
        if user_name.present?
            @@use_case.create_account(user_name , user_id , user_pass , re_pass)
            redirect_to action: "login"
        end
        
    end

    def notification
        gon.user_doc_id = session[:user][Constants::USER_DOC_ID]
        gon.user_id =  session[:user][Constants::USER_ID]
    end

    # ユーザ編集のコントローラ
    def edit_user
    end

    #プロフィール表示のコントローラ
    def mypage_view 
        #############テスト用##############
        # session[:user] = UserUseCase.new.auth()
        ###################################

        # puts session[:user].friends[1][:messageid]
        # puts session[:user].friends.select { |str| str[:friendid] == "test002"}
        # puts "ksdjf;alksdkflj;alskdf;laksj"
        # @user_id = session[:user]["user_id"]
        # @user_name = session[:user]["user_name"]
        # puts session[:user][FireConst::FIRE_COL_FIRENDS].select { |str| str[:friendid] == "test002"}
    end
end
