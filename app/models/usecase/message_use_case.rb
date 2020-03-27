class MessageUseCase
    @@msg_repo = MessageRepositoryFactory.new.repository

    def friend_message(user_doc_id , user_id)
        message_id = @@msg_repo.get_friend_messages_id(user_doc_id , user_id)
        doc_id = @@msg_repo.get_messages_doc_id(message_id)
        return doc_id
    end

    def group_message(group_id)
        message_id = @@msg_repo.get_group_messages_id(group_id)
        doc_id = @@msg_repo.get_messages_doc_id(message_id)
    end
end