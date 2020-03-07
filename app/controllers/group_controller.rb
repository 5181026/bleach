# coding: utf-8

class GroupController < ApplicationController
    @@use_case = GroupUseCase.new
    
    # グループ登録のコントローラ
    def group_add
    end

    # グループ一覧のコントローラ
    def group_view
        #############テスト用##############
        session[:user] = UserUseCase.new.auth()
        ###################################
        @groups = []
        # 検索した値をビューに渡す
        if params[:group_id].present?
            @groups = @@use_case.get_find_id_group(params[:group_id])
        elsif params[:group_name].present?
            @groups = @@use_case.get_find_name_group(params[:group_name])
        end

        if @groups == []
            @groups = @@use_case.get_all_mygroup()
        end
    end

    # グループ情報のコントローラ
    def group_info_view
        @group = @@use_case.get_find_id_group(params[:group_id])[Constants::ZERO]
        @user_id = session[:user]["#{Constants::USER_ID}"]
    end

    #グループ検索のコントローラ
    def group_search
    end
end
