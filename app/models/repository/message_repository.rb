class MessageRepository
    include FirebaseFormat
    
    def initialize(firestore)
        @firestore = firestore
    end

    def get_messages(message_id)
        messages = []
        doc_id = ""

        query = message_col().where(FireConst::FIRE_DOC_MESSAGE_ID , Constants::EQUAL , message_id)

        #message_idが一致したコレクションのドキュメントIDを取得する
        query.get do |m|
            doc_id = m.document_id
        end

        query = message_col.doc(doc_id).col(FireConst::FIRE_DOC_MESSAGE_CONTENT)
        
        #取得したドキュメントIDのcontentを取得
        query.get do |m|
            messages << m.data
        end

        return messages , doc_id
    end
end
