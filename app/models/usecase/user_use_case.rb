# コントローラで使用するクラス
class UserUseCase
    @@user_repo = UserRepositoryFactory.new().repository

    #ログインの認証をする(テスト)
    def auth (user_id = "test001" , user_pass = "test")#テスト用ユーザ
        user_data , auth_doc_id = @@user_repo.get_auth_user(user_id , user_pass)  
        @user = User.new(
            doc_id = auth_doc_id, 
            user_name = user_data[:username], 
            user_id = user_data[:userid],
            user_age = "",
            friends = @@user_repo.get_all_friends(auth_doc_id),
            mygroups = @@user_repo.get_all_mygroup(auth_doc_id),
            create_day = ""
             )
    end

    def get_all_friend(doc_id)
        return @@user_repo.get_all_friends(doc_id)
    end
end