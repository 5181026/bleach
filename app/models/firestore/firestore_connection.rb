require "google/cloud/firestore"

# firestoreに認証するためのクラス
class FirestoreConnection
    def self.get_connection
        id = FirestoreConfig.new().get_firestore_id
        return Google::Cloud::Firestore.new project_id: id
    end
end