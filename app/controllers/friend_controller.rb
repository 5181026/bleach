class FriendController < ApplicationController
    @@use_case = UserUseCase.new

    #フレンド登録のコントローラ
    def friend_add
    end

    #フレンド一覧のコントローラ
    def friend_view
        #############テスト用##############
        session[:user] = UserUseCase.new.auth()
        ###################################
        @friends = []
        
        if params[:friend_id].present?
            @friends = @@use_case.id_find_user(params[:friend_id])
        elsif params[:friend_name].present?
            @friends = @@use_case.name_find_user(params[:friend_name])
        end

        if @friends == [] 
            @friends = @@use_case.get_friends(session[:user].friends)
        end
       
    end

    #フレンド情報のコントローラ
    def friend_info_view
        @friend = @@use_case.id_find_user(params[:friend_id])[Constants::ZERO]
        @ver = @@use_case.get_timestamp_string
    end

    def friend_search
    end
end
