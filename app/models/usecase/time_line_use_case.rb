class TimeLineUseCase
    @@time_line_repo = TimeLineRepositoryFactory.new.repository
    def get_my_time_line(user_doc_id , user_id)
        users_array = @@time_line_repo.get_all_friends(user_doc_id)
        users_array << user_id
        return @@time_line_repo.get_time_line(users_array)
    end

    def time_line_post(user_id , content)
        time_line_id = create_time_line_id(user_id)
        return @@time_line_repo.add_time_line(user_id , time_line_id , content)
    end
    
    def post_good(user_id , time_line_id)
    end

    def create_time_line_id(user_id)
        random = Random.new()
        create_id = "#{user_id}#{random.rand(10**16)}"
        data = @@time_line_repo.get_find_time_line(create_id)
        while data.present? do
            create_id = "#{user_id}#{random.rand(10**16)}"
            data = @@time_line_repo.get_find_message("#{user_id}#{random.rand(10**16)}")
        end

        return create_id
    end

    def add_good_user(good_users_id , time_line_id)
        @@time_line_repo.update_good(good_users_id , time_line_id)
    end
end
