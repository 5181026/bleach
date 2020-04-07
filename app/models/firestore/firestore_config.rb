# firestoreに認証するためのprojectidをjsonファイルから取得するクラス
class FirestoreConfig
    def self.get_firestore_id
        File.open(FireConst::FIRESTORE_JSON_PATH) do |file|
            return JSON.load(file)[FireConst::FIRE_ID]
        end
    end
end

