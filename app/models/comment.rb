class Comment < ActiveRecord::Base
  default_scope -> { order(created_at: :asc) }
  validates :content, presence: true, length:{ maximum: 200 }
  belongs_to :author, class_name: "User"
  belongs_to :commentable, polymorphic: true
end
