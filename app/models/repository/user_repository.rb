# firestoreでuserコレクションに対して読み込みと取得をする

# 途中
class UserRepository
    def initialize(firestore)
        @firestore = firestore
    end

    # 全てのユーザを配列で返す
    def get_all_user
        users = [] 
        @firestore.get do |user|
            users << user.data
        end 
        return users
    end

    # 条件に一致したユーザを返す
    def get_find_user
        users = ""
        query = @firestore.where "userid" , "=" , "test001"
        query.get do |user|
            puts user.data
            users = user.data
        end
        return users
    end
end