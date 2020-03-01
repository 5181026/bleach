# リポジトリのファクトリークラス
class RepositoryFactory
    attr_reader :repository     #repositoryのゲッター

    def initialize(col_name)
        firestore = FirestoreConnection::get_connection     #firestoreのコネクション
        @firestore_col = firestore.col col_name             #firestoreで使うcollectionを指定
        @repository = new_repository                      #factoryクラスを生成したときにインスタンスを生成する。
    end
end

# UserRepositoryのインスタンスを生成をする
class UserRepositoryFactory < RepositoryFactory
    def new_repository
        UserRepository.new(@firestore_col)
    end 
end

# GroupRepositoryのインスタンスの生成をする
class GroupRepositoryFactory < RepositoryFactory
    def new_repository
        GroupRepositoryFactory.new(@firestore_col)
    end
end

# MessageRepositoryのインスタンスを生成する
class MessageRepositoryFactory < RepositoryFactory
    def new_repository
        MessageRepositoryFactory.new(@firestore_col)
    end
end
