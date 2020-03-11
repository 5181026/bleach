class MessageController < ApplicationController
    @@use_case = MessageUseCase.new

    def chat
        friend = session[:user]["friends"].select { |str| str["friendid"] == params[:user_id]}
        @friend_name = params[:friend_name]
        @msg = @@use_case.friend_message(friend[Constants::ZERO]["messageid"])
    end
end
