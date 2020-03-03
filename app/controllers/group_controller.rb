# coding: utf-8

class GroupController < ApplicationController

    # グループ登録のコントローラ
    def group_add
    end

    # グループ一覧のコントローラ
    def group_view
        use_case = UserUseCase.new
        @groups = use_case.get_group
    end

    # グループ情報のコントローラ
    def group_info_view
    end
end
