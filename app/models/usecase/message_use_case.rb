class MessageUseCase
    @@msg_repo = MessageRepositoryFactory.new.repository

    def friend_message(message_id)
        doc_id = @@msg_repo.get_messages(message_id)
        return doc_id
    end
end