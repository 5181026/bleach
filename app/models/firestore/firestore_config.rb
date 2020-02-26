# firestoreに認証するためのprojectidをjsonファイルから取得するクラス
class FirestoreConfig
    def get_firestore_id
        File.open(Constants::FIRESTORE_JSON_PATH) do |file|
            
            return JSON.load(file)["project_id"]
        end
    end
end

