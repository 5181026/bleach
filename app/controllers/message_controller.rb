class MessageController < ApplicationController
    @@use_case = MessageUseCase.new

    def chat
        @header_title = params[:title_name]
        if params[:user_id].present?
            gon.doc_id = @@use_case.friend_message(session[:user][Constants::USER_DOC_ID] , params[:user_id])
        elsif params[:group_id].present?
            gon.doc_id = @@use_case.group_message(params[:group_id])
        end
        gon.user_id = session[:user][Constants::USER_ID]
    end
end
