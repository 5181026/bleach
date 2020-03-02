#firestoreのグループコレクションに対して読み込み書き込みをする
class GroupRepository
    def initialize(firestore)
        @firestore = firestore
    end

    # 全てのグループを取得
    def get_all_group
        friends = []
        query = @firestore.col(FireConst::FIRE_COL_GROUP)
        query.get do |friend|
            friends << friend.data
        end

        return friends 
    end

    #グループのIDで一致した条件のグループを取得
    def get_find_friend
        friends = {}

        query = @firestore.col(FireConst::FIRE_COL_MYGROUP)
            .where(FireConst::FIRE_COL_GROUP_ID , Constants::EQUAL , "test002")

        query.get do |friend|
            friends = friend.data
        end

        return friends 
end