# リポジトリで使用する共通処理

# 途中
module FirebaseFormat
    def user_col
        @firestore.col(FireConst::FIRE_COL_USERS)
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

    def get_data_format(query)
        data = Constants::EMPTY
        query.get do |d|
            data = d.data
        end

        return data
    end

    def get_doc_id_format(query)
        doc_id = Constants::EMPTY
        query.get do |d|
            doc_id = d.document_id
        end

        return doc_id
    end


    def get_arrays_format(query)
        data = []
        query.get do |d|
            data << d.data
        end

        return data
    end

    def multiple_where_format(query , compare_doc , operator , compare_value)
        counter = Constants::ZERO
        compare_value.map do |value|
            query = query.where(compare_doc[counter] , operator , value)
            counter = counter.next
        end
        return query
    end

    # ユーザのdocumentid取得
    def get_find_user_doc_id(user_id)
        doc_id = Constants::EMPTY
        query = user_col().where(FireConst::FIRE_DOC_USER_ID , Constants::EQUAL , user_id)

        query.get do |u|
            doc_id = u.document_id
        end

        return doc_id
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


    # ユーザの全てのfriend_idを配列で返す
    def get_all_friends(doc_id)
        friends_id = []
        query = user_col().doc(doc_id).col(FireConst::FIRE_COL_FIRENDS)
        
        query.get do |f|
            friends_id << f.data[:friendid]
        end
        return friends_id
    end
end