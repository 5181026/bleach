# firestoreでuserコレクションに対して読み込みと取得をする

# 途中
class UserRepository
    def initialize(firestore)
        @firestore = firestore
    end

    def get_all_user
        return @firestore.get
    end
end