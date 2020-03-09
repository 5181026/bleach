# コントローラで使用するクラス
class UserUseCase
    @@user_repo = UserRepositoryFactory.new().repository
    include CreateDatetime
    #ログインの認証をする(テスト)
    def auth (user_id = "test001" , user_pass = "test")#テスト用ユーザ
        user_data , auth_doc_id = @@user_repo.get_auth_user(user_id , user_pass) 
        @user = User.new(
            doc_id = auth_doc_id, 
            user_name = user_data[:name], 
            user_id = user_data[:userid],
            user_age = "",
            friends = @@user_repo.get_all_friends(auth_doc_id),
            mygroups = @@user_repo.get_all_mygroup(auth_doc_id),
            create_datetime = CreateDatetime::get_datetime_string
             )
    end

    def get_friends(user_friends)
        friend = user_friends.map do |s|
            @@user_repo.get_find_user_id(s[:friendid])
        end

        return friend
    end

    def id_find_user(user_id)
        users = []
        users << @@user_repo.get_find_user_id(user_id) 
        users.delete_if { |i| i == {} || i == "" }   #空のハッシュを削除する(本来は必要ない)
    end

    def find_name_user(doc_id , friend_name)
        users = []
        users << @@user_repo.get_find_user_name(doc_id , friend_name)
        users.delete_if { |i| i == {} || i == "" }
    end
end