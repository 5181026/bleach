class MessageRepository
    include FirebaseFormat
    
    def initialize(firestore)
        @firestore = firestore
    end

    # userごとのmessageidを取得する
    def get_messages_id(user_doc_id , user_id)
        message_id = ""

        query = user_col().doc(user_doc_id).col(FireConst::FIRE_COL_FIRENDS)
        .where(FireConst::FIRE_DOC_USER_FRIEND_ID , Constants::EQUAL , user_id)

        query.get do |m|
            message_id = m.data[:messageid]
        end
        return message_id
    end

    #messageのdocdiを取得
    def get_messages_doc_id(message_id)
        # messages = []
        doc_id = ""

        query = message_col().where(FireConst::FIRE_DOC_MESSAGE_ID , Constants::EQUAL , message_id)

        # message_idが一致したコレクションのドキュメントIDを取得する
        query.get do |m|
            doc_id = m.document_id
        end

        query = message_col.doc(doc_id).col(FireConst::FIRE_DOC_MESSAGE_CONTENT)

        return doc_id
    end
end
