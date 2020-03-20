class MessageController < ApplicationController
    @@use_case = MessageUseCase.new

    def chat
        friend = session[:user]["friends"].select { |str| str["friendid"] == params[:user_id]} #一致したユーザを取得する
        @header_title = params[:friend_name]
        gon.doc_id = @@use_case.friend_message(friend[Constants::ZERO]["messageid"])
        gon.user_id = session[:user]["#{Constants::USER_ID}"]
    end
end
