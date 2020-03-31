# コントローラで使用するクラス
class UserUseCase
    @@user_repo = UserRepositoryFactory.new().repository
    
    #ログインの認証をする
    def auth (user_id , user_pass)
        user_data , auth_doc_id = @@user_repo.get_auth_user(user_id , user_pass) 
        @user = User.new(
            doc_id = auth_doc_id, 
            user_name = user_data[:name], 
            user_id = user_data[:userid],
            user_age = "",
            # friends = @@user_repo.get_all_friends(auth_doc_id),
            # mygroup = @@user_repo.get_all_mygroup(auth_doc_id),
            create_datetime = @@user_repo.get_timestamp
            )
    end

    # TODO ユーザのアカウントを登録と値のチェックを行う
    def create_account(user_name , user_id , user_pass , re_pass)
        ########## 値のチェックをする #######

        ###################################
        @@user_repo.create_user(user_name , user_id , user_pass)
    end

    def get_friends(doc_id)
        user_friends = @@user_repo.get_all_friends(doc_id)
        friend = user_friends.map do |s|
            @@user_repo.get_find_user_id(s)
        end
        return friend
    end

    def id_find_user(user_id)
        users = []
        users << @@user_repo.get_find_user_id(user_id) 
        users.delete_if { |i| i == {} || i == "" }   #空のハッシュを削除する(本来は必要ない)
    end

    def name_find_user(friend_name)
        users = []
        users << @@user_repo.get_find_user_name(friend_name)
        users.delete_if { |i| i == {} || i == "" }
    end

    def post_friend_request(user_id , friend_id)
        @@user_repo.add_notification(user_id , friend_id);
    end

    #同じ通知が存在するか
    def friend_request?(friend_id ,user_id)
        doc_id = @@user_repo.get_find_user_doc_id(friend_id)
        notification = @@user_repo.get_find_friend_notification(doc_id , user_id)
        return notification.present?
    end
end