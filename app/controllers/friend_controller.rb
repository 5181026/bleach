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
       @friends = @@use_case.get_all_friend(session[:user].doc_id)
       puts @friends
    end

    #フレンド情報のコントローラ
    def friend_info_view
    end
end
