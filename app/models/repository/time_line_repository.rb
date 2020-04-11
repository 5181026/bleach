# タイムラインのコレクションに読み書きする
class TimeLineRepository
    include FirebaseFormat
    def initialize(firestore)
        @firestore = firestore
    end

    def get_time_line(users)
        time_line = []
        users.map do |user|
            query = time_line_col().where(FireConst::FIRE_DOC_TIMELINE_POST_USER_ID , Constants::EQUAL , user)
            time_line << get_arrays_format(query)
        end
        
        return time_line.flatten  #２次元配列になっているので配列に戻す。
    end

    # タイムラインIDでタイムランを取ってくる
    def get_find_time_line(time_line_id)
        query = time_line_col().where(FireConst , Constants::EQUAL , time_line_id)
        time_line = get_data_format(query)

        return time_line
    end

    def get_time_line_doc_id(time_line_id)
        query = time_line_col.where(FireConst::FIRE_DOC_TIME_LINE_ID , Constants::EQUAL , time_line_id)
        doc_id = get_doc_id_format(query)

        return doc_id
    end

    
    def add_time_line(user_id , time_line_id , content)
        data = {
            timelineid: time_line_id,
            postuserid: user_id,
            content: content,
            gooduserid: [],
            date: Time.now
        }
        added_doc_ref = time_line_col.add data

    end

    def update_good(good_users_id , time_line_id)
        doc_id = get_time_line_doc_id(time_line_id)
        query = time_line_col().doc(doc_id)
        query.update(gooduserid: good_users_id)
    end

end