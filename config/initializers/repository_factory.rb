# リポジトリのファクトリークラス
class RepositoryFactory
    attr_reader :repository     #repositoryのゲッター
    def initialize
        @firestore = FirestoreConnection::get_connection     #firestoreのコネクション
        @repository = new_repository                         #factoryクラスを生成したときにインスタンスを生成する。
    end
end

# UserRepositoryのインスタンスを生成をする
class UserRepositoryFactory < RepositoryFactory
    def new_repository
        UserRepository.new(@firestore)
    end 
end

# GroupRepositoryのインスタンスの生成をする
class GroupRepositoryFactory < RepositoryFactory
    def new_repository
        GroupRepositoryFactory.new(@firestore)
    end
end

# MessageRepositoryのインスタンスを生成する
class TimeLineRepositoryFactory < RepositoryFactory
    def new_repository
        MessageRepositoryFactory.new(@firestore)
    end
end
