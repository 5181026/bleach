class FriendController < ApplicationController
    @@use_case = UserUseCase.new

    #フレンド登録のアクション
    def friend_add
    end

    #フレンド一覧のアクション
    def friend_view
        #############テスト用##############
        # session[:user] = UserUseCase.new.auth()
        ###################################
        @friends = []
        
        if params[:friend_id].present?
            @friends = @@use_case.id_find_user(params[:friend_id])
        elsif params[:friend_name].present?
            @friends = @@use_case.name_find_user(params[:friend_name])
        end

        if @friends == [] 
            # @friends = @@use_case.get_friends(session[:user][FireConst::FIRE_COL_FIRENDS])
            @friends = @@use_case.get_friends(session[:user][Constants::USER_DOC_ID])
        end
    end

    #フレンド情報のアクション
    def friend_info_view
        @friend = @@use_case.id_find_user(params[:friend_id])[Constants::ZERO]
        # 相手のusersの中にこのユーザから送られたフレンド申請があるか調べる
        gon.friend_request_flg = @@use_case.friend_request?(params[:friend_id])
        # すでにフレンドなのか調べる
        myfriends = @@use_case.get_friends(session[:user][Constants::USER_DOC_ID])  
        myfriends.select { |k , v| v == params[:friend_id]} #フレンドに存在してるか調べる
        myfriends.delete_if { |i| i == {} || i == "" }  #配列の中身から空の値を削除する
        gon.friend_flg = myfriends.present?
    end

    def friend_search
    end

    # フレンド申請を送るアクション
    def friend_post_notification
        @@use_case.post_friend_request(session[:user][Constants::USER_ID] , params[:user_id])
    end
end
