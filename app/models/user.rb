class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  # Friendships
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :posts, dependent: :destroy, foreign_key: "author_id"
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy, foreign_key: "author_id"

  has_one :profile, dependent: :destroy

  def feed
    Post.where("author_id IN (?) OR author_id = ?", friend_ids, id)
  end

  def likes?(postlikes)
    postlikes.any? { |like| like.user_id == self.id }
  end
end
