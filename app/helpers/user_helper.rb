module UserHelper
    def replace_to_str(parameter)
        if parameter.blank?
            return Constants::NOT_ENTERED
        end
        return parameter
    end
end
