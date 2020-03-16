# require 'date'
module CreateTimestamp
    def get_timestamp_string
        # now = DateTime.new
        now = Time.now
        datetime = now.strftime("#{Constants::DATETIME_FORMAT}")
    end

end