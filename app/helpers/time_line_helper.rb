module TimeLineHelper
    def good_duplicate?(user_id , good_users_id)
        return good_users_id.select { |id| id == user_id }.blank?
    end
end
