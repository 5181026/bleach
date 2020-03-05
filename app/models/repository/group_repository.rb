#firestoreのグループコレクションに対して読み込み書き込みをする
class GroupRepository
    include FirebaseFormat

    def initialize(firestore)
        @firestore = firestore
    end

    # 全てのグループを取得
    def get_all_group
        query = group_col()

        query.get do |g|
            @groups << g.data
        end

        return @groups
    end

    #グループのIDで一致した条件のグループをハッシュで返す
    def get_find_group_id(group_id)
        query = group_col().where(FireConst::FIRE_DOC_GROUP_ID , Constants::EQUAL , group_id)

        query.get do |g|
            @groups = g.data
        end

        return @groups 
    end


    def get_find_group_name(group_name)
        query = group_col().where(FireConst::FIRE_DOC_GROUP_NAME , Constants::EQUAL , group_name)

        query.get do |g|
            @groups = g.data
        end

        return @groups 
    end


    # グループ内のメンバーを配列で返す
    def get_all_group_user
        query = group_col().doc("C0zpm3X9usKAywkTnCK0").col(FireConst::FIRE_DOC_GROUP_MEMBER_ID)

        query.get do |u|
            @users << u.data
        end

        return @users
    end
end