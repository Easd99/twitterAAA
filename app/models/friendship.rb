class Friendship < ApplicationRecord




def self.find_friendship(id_user, id_friend)
    where("user_id  = ? AND friend_user_id= ?", id_user, id_friend)
end

end