# coding: utf-8

class GroupController < ApplicationController

    # グループ登録のコントローラ
    def group_add
    end

    # グループ一覧のコントローラ
    def group_view
        use_case = GroupUseCase.new
        @groups = use_case.get_group
    end

    # グループ情報のコントローラ
    def group_info_view
    end

    #グループ検索のコントローラ
    def group_search
        # puts params[:group_name]
        redirect_to(group_view_path) if params[:group_name].present?
    end
end
