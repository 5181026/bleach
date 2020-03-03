# firestoreでユーザコレクションに対して読み込みと書き込みをする
# 途中
class UserRepository
    include FirebaseFormat
    def initialize(firestore)
        @firestore = firestore
    end

    # 全てのユーザを配列で返す
    def get_all_user
        users = []
        query = user_col()
        query.get do |user|
            users << user.data
        end

        return users
    end

    #認証したユーザをハッシュで返す
    def get_auth_user(user_id , user_pass)
        users = {}
        doc_id = ""
        query = user_col().where(FireConst::FIRE_DOC_USER_ID , Constants::EQUAL , user_id)
            .where(FireConst::FIRE_DOC_USER_PASS , Constants::EQUAL , user_pass)

        query.get do |user|
            users = user.data
            doc_id = user.document_id
        end

        return users , doc_id
    end

    # 条件にid検索で一致したユーザをハッシュで返す
    def get_find_user
        users = {}
        query = user_col().where(FireConst::FIRE_DOC_USER_ID , Constants::EQUAL , "test001")
        
        query.get do |user|
            puts user.data
            users = user.data
        end

        return users
    end
    
    # ユーザの全てのフレンドを配列で返す
    def get_all_friends(doc_id)
        friends = []
        query = user_col().doc(doc_id).col(FireConst::FIRE_COL_FIRENDS)
        
        query.get do |friend|
            friends << friend.data
        end

        return friends
    end

    # IDが一致したユーザのフレンドを取得
    def get_find_friend(doc_id , friend_id)
        friends = {}
        query = user_col().doc("0JUDhZLTs9dtgKcscDty").col(FireConst::FIRE_COL_FIRENDS)
            .where(FireConst::FIRE_DOC_USER_FRIEND_ID , Constants::EQUAL , "test002")

        query.get do |friend|
            friends = friend.data
        end

        return friends
    end

    # ユーザのグループを全て取得する
    def get_all_mygroup(doc_id)
        mygroups = []
        query = user_col().doc(doc_id).col(FireConst::FIRE_COL_MYGROUP)
        
        query.get do |group|
            mygroups << group.data
        end

        return mygroups
    end

    # IDで一致したグループを取得
    def get_find_mygroup
        mygroups = {}
        query = user_col().doc("0JUDhZLTs9dtgKcscDty").col(FireConst::FIRE_COL_MYGROUP)
            .where(FireConst::FIRE_DOC_GROUP_ID , Constants::EQUAL , "testgroup01")

        query.get do |group|
            mygroups = group.data
        end

        return mygroups
    end
end
