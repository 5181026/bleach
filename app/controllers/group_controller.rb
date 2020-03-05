# coding: utf-8

class GroupController < ApplicationController
    @@use_case = GroupUseCase.new
    # グループ登録のコントローラ
    def group_add
    end

    # グループ一覧のコントローラ
    def group_view
        @groups = []
        # 検索した値をビューに渡す
        if params[:group_id].present?
            @groups = @@use_case.get_search_id_group(params[:group_id])
        elsif params[:group_name].present?
            @groups = @@use_case.get_search_name_group(params[:group_name])
        else
            @groups = @@use_case.get_all_mygroup()
        end
    end

    # グループ情報のコントローラ
    def group_info_view
    end

    #グループ検索のコントローラ
    def group_search
    end
end
