class TimeLineController < ApplicationController
    @@use_case = TimeLineUseCase.new
    def time_line_view
        @time_lines = @@use_case.get_my_time_line(session[:user][Constants::USER_DOC_ID] , session[:user][Constants::USER_ID])
        @time_lines = @time_lines.sort{|new_times , old_times| new_times[:date] <=> old_times[:date]}.reverse
        puts @time_lines
    end

    def time_line_post
        if params[:post_content].present?
            @@use_case.time_line_post(session[:user][Constants::USER_ID] , params[:post_content])
            redirect_to action: "time_line_view"
        end 
    end

    def click_good_icon
        puts "クリックされました#{params[:time_line_id]}"
        good_users = "" 
        # good_users_id.select { |id| id == user_id }
        if params[:good_user].present?
            # 既に登録されているか確認する。
            if params[:good_user].select {|id| id == session[:user][Constants::USER_ID]}.blank?
                good_users = params[:good_user] << session[:user][Constants::USER_ID]
            else
                good_users = params[:good_user].select {|id| id != session[:user][Constants::USER_ID]}
            end
        else
            good_users = [session[:user][Constants::USER_ID]]
        end

        puts "グッドユーザ#{good_users[0].class}"
        @@use_case.add_good_user(good_users , params[:time_line_id])
    end
end
