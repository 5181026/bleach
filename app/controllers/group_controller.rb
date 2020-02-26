# coding: utf-8

class GroupController < ApplicationController

    # グループ登録のコントローラ
    def group_add
    end

    # グループ一覧のコントローラ
    def group_view
        @groupname = Constants::HELLO   #定数の書き方
    end

    # グループ情報のコントローラ
    def group_info_view
    end
end
