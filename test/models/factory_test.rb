require "test_helper"
require "google/cloud/firestore"


# factoryクラスのUserRepositoryFactoryインスタンス生成テスト
class FirestoreConnectionTest <  ActiveSupport::TestCase
    test "factory should connection" do
        assert UserRepositoryFactory.new("user").present?
    end
end