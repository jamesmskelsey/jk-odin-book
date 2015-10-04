class Post < ActiveRecord::Base
  validates :content, presence: true, length: {maximum: 200}
  validate  :picture_size
  default_scope -> {order(created_at: :desc)}
  belongs_to :author, class_name: "User"

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  mount_uploader :picture, PictureUploader

  private

    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
