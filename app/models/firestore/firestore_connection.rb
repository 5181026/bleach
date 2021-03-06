require 'logger'
require "google/cloud/firestore"

# firestoreに認証するためのクラス
class FirestoreConnection
    def self.get_connection
        begin
            # id = FirestoreConfig::get_firestore_id
            # return Google::Cloud::Firestore.new project_id: id
            # firebaseに環境変数を使って接続する。 
            puts "環境変数===#{ENV['FIREBASE']}"
            return Google::Cloud::Firestore.new project_id: ENV['FIREBASE']
        rescue => e
            #サーバ立ち上げ時にFireStoreと接続できなければサーバを止める
            puts "エラー：FireBaseに接続できませんでした。アプリを終了します。"
            log = Logger.new('./rubyflie.log')
            log.error("FireBaseError接続に失敗しました。")
            # logger.error e 
            # logger.error e.backtrace.join("\n") 
            exit!
        end
    end
end