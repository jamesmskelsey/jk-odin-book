class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]


  # Friendships
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :posts, dependent: :destroy, foreign_key: "author_id"
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy, foreign_key: "author_id"

  has_one :profile, dependent: :destroy

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        if auth.info.email.nil?
          user.email = auth.uid + "@facebookauth.com"
        else
          user.email = auth.info.email
        end
        user.password = Devise.friendly_token[0,20]
      end
  end

  def feed
    Post.where("author_id IN (?) OR author_id = ?", realfriends, id)
  end

  def likes?(postlikes)
    postlikes.any? { |like| like.user_id == self.id }
  end

  def realfriends
    a = Array.new
    self.friendships.where("status = 'accepted'").each { |f| a << f.friend_id }
    a.uniq
  end
end
