class GroupUseCase
    @@group_repo = GroupRepositoryFactory.new.repository

    def get_all_mygroup
        #############テスト用##############
        @user = UserUseCase.new.auth()
        ###################################

        #ユーザからgroupidを調べて取得する。
        mygroup = @user.mygroups.map do |s| 
            @@group_repo.get_find_group_id(s[:groupid]) 
        end
        mygroup.delete_if { |i| i == {} }   #空のハッシュを削除する(本来は必要ない)
        return mygroup
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
end