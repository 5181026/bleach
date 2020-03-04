class GroupUseCase

    def get_group
        # user_repo = UserRepositoryFactory.new.repository
        # return user_repo.get_all_mygroup
        
        #テスト用
        @user = UserUseCase.new.auth()
        group_repo = GroupRepositoryFactory.new.repository
        # return @user.mygroups
        
        #ユーザからgroupidを調べて取得する。
        mygroup = @user.mygroups.map do |s| 
            group_repo.get_find_group(s[:groupid]) 
        end

        mygroup.delete_if { |i| i == {} }   #空のハッシュを削除する(本来は必要ない)

        puts mygroup
        return mygroup
    end 
end