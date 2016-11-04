class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :product

  validates :product_id, presence: true
  validates :user, presence: true
  validates :description, length: { maximum: 140 }
  validates :rating, presence: true,
    numericality: {
      only_integer: true,
      less_than_or_equal_to: 5
     }

end
