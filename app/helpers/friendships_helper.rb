module FriendshipsHelper
  def get_friendship(user_id, friend_id)
    Friendship.where("user_id = ? AND friend_id = ?", user_id, friend_id).first
  end

  # Returns true if the friendship already exists, used to force uniqueness at the controller level. Won't create new association.
  def friendship_exists?(user_id, friend_id)
    !get_friendship(user_id, friend_id).nil?
  end
end
