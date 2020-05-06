# コントローラで使用するクラス
require 'digest'

class UserUseCase
    @@user_repo = UserRepositoryFactory.new().repository
    
    #ログインの認証をする
    def auth (user_id , user_pass)
        user_pass = password_digest(user_id , user_pass)
        user_data , auth_doc_id = @@user_repo.get_auth_user(user_id , user_pass) 
        if user_data.present?
            @user = User.new(
                doc_id = auth_doc_id, 
                user_name = user_data[:name], 
                user_id = user_data[:userid],
                user_mail = user_data[:mail],
                user_age = user_data[:age],
                create_datetime = Time.now
                )
        else
            return raise ActiveRecord::RecordNotFound
        end
    end

    
    def create_account(user_name , user_id , user_pass , re_pass)
        user_pass = password_digest(user_id , user_pass)
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
        # users.delete_if { |i| i == {} || i == Constants::EMPTY }   #空のハッシュを削除する(本来は必要ない)
    end

    def name_find_user(friend_name)
        users = []
        users << @@user_repo.get_find_user_name(friend_name)
        users.delete_if { |i| i == {} || i == Constants::EMPTY }
    end

    def post_friend_request(user_id , friend_id)
        @@user_repo.add_notification(user_id , friend_id);
    end

    #同じ通知が存在するか確認する
    def friend_request?(friend_id ,user_id)
        doc_id = @@user_repo.get_find_user_doc_id(friend_id)
        notification = @@user_repo.get_find_friend_notification(doc_id , user_id)
        return notification.present?
    end

    def user_parameter_edit(user)
        @@user_repo.user_update(user)
    end

    # ユーザのパスワードを暗号化
    def password_digest(user_id , pass)
        digest_pass = Digest::SHA1.hexdigest(pass);
        salt = Digest::SHA1.hexdigest(user_id);
        return Digest::SHA1.hexdigest("#{salt}#{digest_pass}")
    end

    def create_parameter_confirm?(user_name , user_id , user_pass , re_pass)
        return user_name.present? && user_id.present? && user_pass.present? && re_pass.present? && user_pass == re_pass
    end
end