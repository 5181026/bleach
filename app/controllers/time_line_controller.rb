class TimeLineController < ApplicationController
    @@use_case = TimeLineUseCase.new
    def time_line_view
        @time_lines = @@use_case.get_my_time_line(session[:user][Constants::USER_DOC_ID] , session[:user][Constants::USER_ID])
        puts @time_lines
        puts "上野がコンテント"
    end
end
