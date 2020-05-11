# coding: utf-8

class GroupController < ApplicationController
    @@use_case = GroupUseCase.new
    
    # グループ登録のコントローラ
    def group_create
        @header_title = Constants::GROUP_CREATE_TITLE
        if params[:group_id].present?
            @@use_case.create_new_group(params[:group_id] , params[:group_name],
                session[:user][Constants::USER_ID] , session[:user][Constants::USER_DOC_ID])
            redirect_to action: :group_view
        end
    end

    # グループ一覧のコントローラ
    def group_view
        @groups = []
        # 検索した値をビューに渡す
        if params[:group_id].present?
            @groups = @@use_case.get_find_id_group(params[:group_id])
        elsif params[:group_name].present?
            @groups = @@use_case.get_find_name_group(params[:group_name])
        else
            @groups = @@use_case.get_all_mygroup(session[:user][Constants::USER_DOC_ID])
        end

        if @groups == [] && params[:commit].present?
            flash[:alert] = Constants::W_001
            redirect_to action: :group_search
        end
    end

    # グループ情報のコントローラ
    def group_info_view
        @group = @@use_case.get_find_id_group(params[:group_id])[Constants::ZERO]
        @admin_user_name = @@use_case.get_user(@group[:createuserid])[:name]
        @group_members = @@use_case.get_group_members(params[:group_id])
        @user_id = session[:user][Constants::USER_ID]
        # 同じ通知があるか確認する
        gon.group_request_flg = @@use_case.group_request?(params[:create_user_id] , session[:user][Constants::USER_ID])
        #既にグループのメンバーか確認する
        gon.group_flg = @@use_case.group_members?(session[:user][Constants::USER_DOC_ID] , params[:group_id])
    end

    #グループ検索のコントローラ
    def group_search
    end

    # notificationにグループの招待を追加する
    def group_post_notification
        @@use_case.post_join_group_request(session[:user][Constants::USER_ID] , params[:create_user_id] , params[:group_id]);
    end

    def group_edit
        @header_title = Constants::EDIT_TITLE
        @group_name = params[:group_name]
        @group_id = params[:group_id]
        gon.id = @group_id
    end

    def click_group_edit_button
        @@use_case.edit_group_parameter(params[:group_id] , params[:group_name])
        # redirect_back(fallback_location: group_info_view_path)
        redirect_to action: :group_info_view , create_user_id: session[:user][Constants::USER_ID] , group_id: params[:group_id] 
    end
end
