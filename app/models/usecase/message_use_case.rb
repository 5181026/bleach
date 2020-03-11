class MessageUseCase
    @@msg_repo = MessageRepositoryFactory.new.repository

    def friend_message(message_id)
        return @@msg_repo.get_messages(message_id)
    end
end