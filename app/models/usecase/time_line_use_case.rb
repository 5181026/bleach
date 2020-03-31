class TimeLineUseCase
    @@time_line_repo = TimeLineRepositoryFactory.new.repository
    def get_my_time_line(user_doc_id , user_id)
        users_array = @@time_line_repo.get_all_friends(user_doc_id)
        users_array << user_id
        return @@time_line_repo.get_time_line(users_array)
    end
end