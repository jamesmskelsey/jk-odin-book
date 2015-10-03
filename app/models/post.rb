class Post < ActiveRecord::Base
  validates :content, presence: true, length: {maximum: 200}
  default_scope -> {order(created_at: :desc)}
  belongs_to :author, class_name: "User"

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
end
