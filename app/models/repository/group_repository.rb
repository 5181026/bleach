#firestoreのグループコレクションに対して読み込み書き込みをする
class GroupRepository
    include FirebaseFormat

    def initialize(firestore)
        @firestore = firestore
    end

    # 全てのグループを取得
    def get_all_group
        groups = []
        query = group_col()

        query.get do |g|
            groups << g.data
        end

        return groups
    end

    
    def get_all_user_mygroup(doc_id)
        mygroups = []
        query = user_col().doc(doc_id).col(FireConst::FIRE_COL_MYGROUP)
        
        query.get do |g|
            mygroups << g.data
        end
        
        groups = []
        mygroups.map do |i|
            group_col.where(FireConst::FIRE_DOC_GROUP_ID , Constants::EQUAL , i[:groupid]).get do |g|
               groups << g.data
            end
        end 
        return groups
    end

    #グループのIDで一致した条件のグループをハッシュで返す
    def get_find_group_id(group_id)
        groups = ""
        query = group_col().where(FireConst::FIRE_DOC_GROUP_ID , Constants::EQUAL , group_id)

        query.get do |g|
            groups = g.data
        end

        return groups 
    end


    def get_find_group_name(group_name)
        groups = ""
        query = group_col().where(FireConst::FIRE_DOC_GROUP_NAME , Constants::EQUAL , group_name)

        query.get do |g|
            groups = g.data
        end

        return groups 
    end


    # グループ内のメンバーを配列で返す
    def get_all_group_user
        users = []
        query = group_col().doc("C0zpm3X9usKAywkTnCK0").col(FireConst::FIRE_DOC_GROUP_MEMBER_ID)

        query.get do |u|
            users << u.data
        end

        return users
    end

    # 新しくグループを作成する
    def add_create_group(group_id , group_name , user_id , user_doc_id , message_id)
        data = {
            createuserid: user_id,
            groupid: group_id,
            groupname: group_name,
            messageid: message_id,
            date: get_timestamp()
        }

        added_doc_ref = group_col().add data

        "Added document with ID: #{added_doc_ref.document_id}."
        # message collectionを追加する
        data = {
            messageid: message_id
        }

        added_doc_ref = message_col().add data

        "Added document with ID: #{added_doc_ref.document_id}."

        add_group_members(added_doc_ref.document_id , user_id , group_id , user_doc_id)

    end

    # グループのメンバに追加しユーザーのmygroupにもグループを追加する。
    def add_group_members(doc_id , user_id , group_id , user_doc_id)

        data = {
            memberid: user_id
        }

        added_doc_ref = group_col().doc(doc_id).col(FireConst::FIRE_COL_MEMBER).add data
        
        "Added document with ID: #{added_doc_ref.document_id}."

        data = {
            groupid: group_id
        }

        added_doc_ref = user_col().doc(user_doc_id).col(FireConst::FIRE_COL_MYGROUP).add data

        "Added document with ID: #{added_doc_ref.document_id}."
    end

    #グループの入るための通知(notification)を追加する
    def add_group_join_notification(user_id , create_user_id , group_id)
        doc_id = ""
        data = {
            notificationid: FireConst::NOTIFICATION_GROUP_JOIN_ID,
            postuserid: user_id,
            groupid: group_id,
            date: get_timestamp
        }

        query = user_col().where(FireConst::FIRE_DOC_USER_ID , Constants::EQUAL , create_user_id)

        query.get do |u|
            doc_id = u.document_id
        end

        added_doc_ref = user_col().doc(doc_id).col(FireConst::FIRE_COL_NOTIFICATION).add data

        "Added document with ID: #{added_doc_ref.document_id}."
    end

    def get_find_group_notification(doc_id , user_id)
        notification = ""
        query = user_col().doc(doc_id).col(FireConst::FIRE_COL_NOTIFICATION).
            where(FireConst::FIRE_DOC_NOTIFICATION_POST_ID , Constants::EQUAL , user_id);
        
        query.get do |n|
            notification = n.data if n.data[:notificationid][Constants::ZERO] == FireConst::NOTIFICATION_GROUP_JOIN_ID[Constants::ZERO]
        end
        
        return notification
    end

    def get_find_mygroup(doc_id , group_id)
        group = ""

        query = user_col().doc(doc_id).col(FireConst::FIRE_COL_MYGROUP).
            where(FireConst::FIRE_DOC_GROUP_ID , Constants::EQUAL , group_id)

        query.get do |g|
            group = g.data
        end

        return group
    end

    # message_idが同じか確認するため
    def get_find_message(message_id)
        message = ""

        query = message_col().where(FireConst::FIRE_DOC_MESSAGE_ID , Constants::EQUAL , message_id)

        query.get do |m|
            message = m.data
        end

        return message
    end
end
