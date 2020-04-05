# リポジトリで使用する共通処理

# 途中
module FirebaseFormat
    include Timestamp
    def user_col
        @firestore.col(FireConst::FIRE_COL_USERS)
    end

    def user_sub_col(doc_id , col_name)
        @firestore.col("#{FireConst::FIRE_COL_USERS}").doc("#{doc_id}").col("#{col_name}")
    end

    def group_col
        @firestore.col(FireConst::FIRE_COL_GROUP)
    end

    def message_col
        @firestore.col(FireConst::FIRE_COL_MESSAGE)
    end

    def time_line_col
        @firestore.col(FireConst::FIRE_COL_TIMELINE)
    end

    # ユーザのdocumentid取得
    def get_find_user_doc_id(user_id)
        doc_id = ""
        query = user_col().where(FireConst::FIRE_DOC_USER_ID , Constants::EQUAL , user_id)

        query.get do |u|
            doc_id = u.document_id
        end

        return doc_id
    end

    # ユーザの全てのfriend_idを配列で返す
    def get_all_friends(doc_id)
        friends_id = []
        query = user_col().doc(doc_id).col(FireConst::FIRE_COL_FIRENDS)
        
        query.get do |f|
            friends_id << f.data[:friendid]
        end
        return friends_id
    end

    def where_format(query , compare_doc , operator , *compare_value)
        compare_value.map do |value|
            query = query.where(compare_doc , operator , value)
        end
        return query
    end
end