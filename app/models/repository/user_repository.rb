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
        query.get do |u|
            users << u.data
        end

        return users
    end

    #認証したユーザをハッシュで返す
    #ユーザのdocidを返す
    def get_auth_user(user_id , user_pass)
        users = {}
        doc_id = ""
        query = user_col().where(FireConst::FIRE_DOC_USER_ID , Constants::EQUAL , user_id)
            .where(FireConst::FIRE_DOC_USER_PASS , Constants::EQUAL , user_pass)

        query.get do |u|
            users = u.data
            doc_id = u.document_id
        end

        return users , doc_id
    end

    # 条件にid検索で一致したユーザをハッシュで返す
    def get_find_user_id(user_id)
        users = {}
        query = user_col().where(FireConst::FIRE_DOC_USER_ID , Constants::EQUAL , user_id)
        
        query.get do |u|
            users = u.data
        end

        return users
    end

    def get_find_user_name(user_name)
        users = {}
        query = user_col().where(FireConst::FIRE_DOC_USER_NAME , Constants::EQUAL , user_name)

        query.get do |u|
            users = u.data
        end

        return users
    end
    
    # ユーザの全てのフレンドを配列で返す
    def get_all_friends(doc_id)
        friends = []
        query = user_col().doc(doc_id).col(FireConst::FIRE_COL_FIRENDS)
        
        query.get do |f|
            friends << f.data
        end
        return friends
    end

    # IDが一致したユーザのフレンドを取得
    def get_id_find_friend(doc_id , friend_id)
        friends = {}
        query = user_col().doc(doc_id).col(FireConst::FIRE_COL_FIRENDS)
            .where(FireConst::FIRE_DOC_USER_FRIEND_ID , Constants::EQUAL , friend_id)

        query.get do |f|
            friends = f.data
        end

        return friends
    end

    # フレンドを名前検索で一致したものをハッシュで返す
    def get_name_find_friend(doc_id , friend_name)
        friends = {}
        query = user_col().doc(doc_id).col(FireConst::FIRE_COL_FIRENDS)
            .where(FireConst::FIRE_DOC_USER_FRIEND_NAME , Constants::EQUAL , friend_name)
        
        query.get do |f|
            friends = f.data
        end

        return friends
    end

    # ユーザのグループを全て取得する
    # def get_all_mygroup(doc_id)
    #     mygroups = []
    #     query = user_col().doc(doc_id).col(FireConst::FIRE_COL_MYGROUP)
        
    #     query.get do |g|
    #         mygroups << g.data
    #     end

    #     return mygroups
    # end

    # IDで一致したグループを取得
    def get_find_mygroup(doc_id , group_id)
        mygroups = {}
        query = user_col().doc(doc_id).col(FireConst::FIRE_COL_MYGROUP)
            .where(FireConst::FIRE_DOC_GROUP_ID , Constants::EQUAL , group_id)

        query.get do |g|
            mygroups = g.data
        end

        return mygroups
    end

    # ユーザを追加するための関数
    def create_user(user_name , user_id , user_pass)
        # 追加するデータのハッシュ
        data = {
            name: user_name,
            userid: user_id,
            password: user_pass,
            age: "",
            createdatetime: get_timestamp
        }

        #userコレクションにドキュメントを追加
        query = user_col()

        added_doc_ref = query.add data
        puts "Added document with ID: #{added_doc_ref.document_id}."

        # friendコレクションを追加
        # query = user_sub_col(added_doc_ref.document_id , FireConst::FIRE_COL_FIRENDS);

        # query.add(
        #     friendid: "",
        #     messageid: ""
        # )
        # puts "Added data to the friends document in the users collection."

        # mygroupコレクションを追加
        # query = user_sub_col(added_doc_ref.document_id, FireConst::FIRE_COL_MYGROUP);
        
        # query.add(
        #     groupid: "",
        #     messageid: ""
        # )
        # puts "Added data to the mygroup document in the users collection."

        #notificationコレクションを追加
        # query = user_sub_col(added_doc_ref.document_id , FireConst::FIRE_COL_NOTIFICATION)

        # query.add(
        #     notificationid: "",
        #     messageid: "",
        #     date: get_timestamp
        # )
        # puts "Added data to the notification document in the users collection."
    end

    def add_notification(notification_id , post_user_id , user_id)
        doc_id = ""
        data = {
            notificationid: notification_id,
            postuserid: post_user_id,
            date: get_timestamp
        }

        query = user_col().where(FireConst::FIRE_DOC_USER_ID , Constants::EQUAL , user_id)

        query.get do |u|
            doc_id = u.document_id
        end

        query = user_sub_col(doc_id , FireConst::FIRE_COL_NOTIFICATION)

        added_doc_ref = query.add data
        "Added document with ID: #{added_doc_ref.document_id}."
    end
end
