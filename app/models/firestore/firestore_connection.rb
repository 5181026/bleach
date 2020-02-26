require "google/cloud/firestore"

# firestoreに認証するためのクラス
class FirestoreConnection
    def initialize(firestore_id)
        @firestore_id = firestore_id
    end

    def firestore_get_connection
        return Google::Cloud::Firestore.new project_id: @firestore_id
    end
end