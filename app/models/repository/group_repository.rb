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

        return mygroups
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
end