# リポジトリで使用する共通処理

# 途中
module FirebaseFormat
    include CreateTimestamp
    def user_col
        @firestore.col(FireConst::FIRE_COL_USERS)
    end

    def add_user_col(doc_id , col_name)
        # @firestore.doc("#{FireConst::FIRE_COL_USERS}/#{doc_id}/#{col_name}")
        @firestore.col("#{FireConst::FIRE_COL_USERS}").doc("#{doc_id}").col("#{col_name}")
    end

    def group_col
        @firestore.col(FireConst::FIRE_COL_GROUP)
    end

    def message_col
        @firestore.col(FireConst::FIRE_COL_MESSAGE)
    end
end