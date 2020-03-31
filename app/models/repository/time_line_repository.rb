# タイムラインのコレクションに読み書きする
class TimeLineRepository
    include FirebaseFormat
    def initialize(firestore)
        @firestore = firestore
    end

    def get_time_line(users)
        time_line = []
        users.map do |user|
            # query = time_line_col().where(FireConst::FIRE_DOC_TIMELINE_POST_USER_ID , Constants::EQUAL , user_id)
            query = where_format(time_line_col , FireConst::FIRE_DOC_TIMELINE_POST_USER_ID , Constants::EQUAL , user)
            # query = where_format(query , FireConst::FIRE_DOC_TIMELINE_POST_USER_ID , Constants::EQUAL , friends_id)
            query.get do |t|
                time_line << t.data
            end
        end
        
        return time_line
    end
end