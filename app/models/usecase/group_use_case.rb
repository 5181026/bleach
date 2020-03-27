class GroupUseCase
    @@group_repo = GroupRepositoryFactory.new.repository

    def get_all_mygroup(doc_id)
        #ユーザからgroupidを調べて取得する。
        mygroup_id = @@group_repo.get_all_user_mygroup(doc_id)
        mygroups = mygroup_id.map do |s| 
            @@group_repo.get_find_group_id(s[:groupid]) 
        end
        mygroups.delete_if { |i| i == {} }   #空のハッシュを削除する(本来は必要ない)
        puts mygroups
        return mygroups
    end 

    #グループIDで検索し配列で返す
    def get_find_id_group(group_id)
        mygroup = []
        mygroup << @@group_repo.get_find_group_id(group_id) 
        mygroup.delete_if { |i| i == {} || i == "" }   #空のハッシュを削除する(本来は必要ない)
    end

    #グループ名で検索し配列で返す
    def get_find_name_group(group_name)
        mygroup = []
        mygroup << @@group_repo.get_find_group_name(group_name)
        mygroup.delete_if { |i| i == {} || i == "" }   #空のハッシュを削除する(本来は必要ない)
    end

    def create_new_group(group_id , group_name , user_id , user_doc_id)
        message_id = create_group_message_id
        unless group_id_exists?(group_id)
            @@group_repo.add_create_group(group_id , group_name , user_id , user_doc_id , message_id)
        end
    end

    def create_group_message_id
        random = Random.new()
        firstChar = "G"
        message_id = @@group_repo.get_find_message("#{firstChar}#{random.rand(10**16)}")
        while message_id.present? do 
            @@group_repo.get_find_message("#{firstChar}#{random.rand(10**16)}")
        end
    end

    def group_id_exists?(group_id)
        return @@group_repo.get_find_group_id(group_id).present?
    end

    def post_join_group_request(user_id , create_user_id , group_id)
        @@group_repo.add_group_join_notification(user_id , create_user_id , group_id)
    end

    # 同じ通知が存在するか確認する
    def group_request?(group_admin_id , user_id)
        doc_id = @@group_repo.get_find_user_doc_id(group_admin_id)
        notification = @@group_repo.get_find_group_notification(doc_id , user_id)
        return notification.present?
    end

    def group_members?(doc_id , group_id)
        group = @@group_repo.get_find_mygroup(doc_id , group_id)
        return group.present?
    end
end