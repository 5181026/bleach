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
        unless group_id_exists?(group_id)
            @@group_repo.add_create_group(group_id , group_name , user_id , user_doc_id)
        end
    end

    def group_id_exists?(group_id)
        return @@group_repo.get_find_group_id(group_id).present?
    end
end