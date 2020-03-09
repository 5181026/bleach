require 'date'
module CreateDatetime
    def self.get_datetime_string
        now = DateTime.new
        datetime = now.strftime("#{Constants::DATETIME_FORMAT}")
    end
end