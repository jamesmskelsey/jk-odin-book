class Profile < ActiveRecord::Base
  validates :first_name, presence: true, length: { maximum: 50, minimum: 3 }
  validates :last_name, presence: true, length: { maximum: 50 }


  belongs_to :user

  def full_name
    "#{self.last_name}, #{self.first_name}"
  end
end
