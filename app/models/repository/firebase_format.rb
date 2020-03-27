# リポジトリで使用する共通処理

# 途中
module FirebaseFormat
    include CreateTimestamp
    def user_col
        @firestore.col(FireConst::FIRE_COL_USERS)
    end

    def user_sub_col(doc_id , col_name)
        # @firestore.doc("#{FireConst::FIRE_COL_USERS}/#{doc_id}/#{col_name}")
        @firestore.col("#{FireConst::FIRE_COL_USERS}").doc("#{doc_id}").col("#{col_name}")
    end

    def group_col
        @firestore.col(FireConst::FIRE_COL_GROUP)
    end

    def message_col
        @firestore.col(FireConst::FIRE_COL_MESSAGE)
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
end