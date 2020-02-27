require "test_helper"
require "google/cloud/firestore"

# firestoreの接続テスト
class FirestoreConnectionTest <  ActiveSupport::TestCase
    # setupでfirestoreのidを取得する
    def setup
        @id = FirestoreConfig.new().get_firestore_id
    end

    # firestore接続し中の値が存在するかをテストする
    test "firestore should connection" do
        con = FirestoreConnection.new(@id)
        firestore = con.firestore_get_connection
        user = firestore.col Constants::FIRE_COL_USERS
        user.get do |u|
            @data = "#{u.data}"
        end
        assert @data.present?
    end
end