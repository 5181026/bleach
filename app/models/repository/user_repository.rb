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
        users = get_data_format(query)

        return users
    end

    #認証したユーザを返す
    #ユーザのdocidを返す
    def get_auth_user(user_id , user_pass)
        users = {}
        doc_id = Constants::EMPTY
        compare_doc = [FireConst::FIRE_DOC_USER_ID , FireConst::FIRE_DOC_USER_PASS]
        compare_value = [user_id , user_pass]
        query = multiple_where_format(user_col , compare_doc , Constants::EQUAL , compare_value)

        query.get do |u|
            users = u.data
            doc_id = u.document_id
        end
        return users , doc_id
    end

    #ユーザ名が一致したものを返す
    def get_find_user_name(user_name)
        users = Constants::EMPTY
        query = user_col.where(FireConst::FIRE_DOC_USER_NAME , Constants::EQUAL , user_name)
        users = get_data_format(query)

        return users
    end

    # IDが一致したユーザのフレンドを取得
    def get_id_find_friend(doc_id , friend_id)
        query = user_col().doc(doc_id).col(FireConst::FIRE_COL_FIRENDS)
            .where(FireConst::FIRE_DOC_USER_FRIEND_ID , Constants::EQUAL , friend_id)
        friends = get_data_format(query)

        return friends
    end

    # フレンドを名前検索で一致したものをハッシュで返す
    def get_name_find_friend(doc_id , friend_name)
        friends = {}
        query = user_col().doc(doc_id).col(FireConst::FIRE_COL_FIRENDS)
            .where(FireConst::FIRE_DOC_USER_FRIEND_NAME , Constants::EQUAL , friend_name)
        friends = get_data_format(query)

        return friends
    end

    # IDで一致したグループを取得
    def get_find_mygroup(doc_id , group_id)
        mygroups = {}
        query = user_col().doc(doc_id).col(FireConst::FIRE_COL_MYGROUP)
            .where(FireConst::FIRE_DOC_GROUP_ID , Constants::EQUAL , group_id)
        mygroups = get_data_format(query)

        return mygroups
    end

    # ユーザを追加するための関数
    def create_user(user_name , user_id , user_pass)
        # 追加するデータのハッシュ
        data = {
            name: user_name,
            userid: user_id,
            password: user_pass,
            age: Constants::EMPTY,
            createdatetime: Time.now
        }

        #userコレクションにドキュメントを追加
        query = user_col()

        added_doc_ref = query.add data
    end

    def add_notification(post_user_id , user_id)
        doc_id = Constants::EMPTY
        data = {
            notificationid: FireConst::NOTIFICATION_FRIEND_REQUEST_ID,
            postuserid: post_user_id,
            date: Time.now
        }

        query = user_col().where(FireConst::FIRE_DOC_USER_ID , Constants::EQUAL , user_id)
        doc_id = get_doc_id_format(query)

        query = user_col().doc(doc_id).col(FireConst::FIRE_COL_NOTIFICATION)

        added_doc_ref = query.add data
            
    end

    def get_find_friend_notification(doc_id , user_id)
        notification = Constants::EMPTY
        query = user_col().doc(doc_id).col(FireConst::FIRE_COL_NOTIFICATION).
            where(FireConst::FIRE_DOC_NOTIFICATION_POST_ID , Constants::EQUAL , user_id)

        query.get do |n|
            notification  = n.data if n.data[:notificationid][Constants::ZERO] == FireConst::NOTIFICATION_FRIEND_REQUEST_ID[Constants::ZERO]
        end

        return notification
    end

    def user_update(user)
        query = user_col().doc(user[Constants::USER_DOC_ID]) 
        query.update name: user[:user_name] , mail: user[:user_mail] , age: user[:user_age]
    end
end