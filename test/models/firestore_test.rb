require "test_helper"
require "google/cloud/firestore"

# firestoreの接続テスト
class FirestoreConnectionTest <  ActiveSupport::TestCase
    # setupでfirestoreのidを取得する

    # firestore接続し中の値が存在するかをテストする
    # test "firestore should connection" do
    #     firestore = FirestoreConnection::get_connection
    #     user = firestore.col FireConst::FIRE_COL_USERS
    #     user.get do |u|
    #         @data = "#{u.data}"
    #     end
    #     assert @data.present?
    # end
end