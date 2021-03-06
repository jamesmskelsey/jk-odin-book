class Friendship < ActiveRecord::Base

  validates :user_id, presence: true
  validates :friend_id, presence: true
  #accepted friends are good to go
  #requested friends are one that the user asked to be their friend
  #pending requests are the ones asked of the user
  #denied requests should go away
  validates :status, inclusion: { in: %w(accepted requested pending denied),
                                  message: "%{value} is not a valid friendship value."}

  belongs_to :user
  belongs_to :friend, class_name: "User", foreign_key: "friend_id"

  scope :accepted, -> { where("status = 'accepted'") } #both people see Accepted as friends
  scope :pending,  -> { where("status = 'pending'") } # the person receiving the request sees pending
  scope :requested, -> { where("status = 'requested'")} # the person requesting the friendship sees requested

  #def self.friendship_exists?(user_id, friend_id)
  #  raise
  #  !get_friendship(user_id, friend_id).nil?
  #end

  #def get_friendship(user_id, friend_id)
  #  raise
  #  Friendship.where("user_id = ? AND friend_id = ?", user_id, friend_id).first
  #end
end
