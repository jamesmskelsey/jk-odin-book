class Profile < ActiveRecord::Base
  validates :first_name, presence: true, length: { maximum: 50, minimum: 3 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validate :picture_size 

  belongs_to :user

  mount_uploader :picture, PictureUploader

  def full_name
    "#{self.last_name}, #{self.first_name}"
  end

  private

    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
