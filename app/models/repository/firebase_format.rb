# リポジトリで使用する共通処理

# 途中
module FirebaseFormat
    def user_col
        @firestore.col(FireConst::FIRE_COL_USERS)
    end
end