# userの情報を格納するクラス
#まだ登録されてないものはに登録の文字列を入れる

class User
    attr_accessor :doc_id , :user_name , :user_id , :user_age , :friends , :mygroups , :create_day
    def initialize(doc_id , user_name , user_id , user_age , friends , mygroups , create_day)
        @doc_id = doc_id
        @user_name = user_name
        @user_id = user_id
        @user_age = user_age
        @friends = friends
        @mygroups = mygroups
        @create_day = create_day
    end
end