class Product < ActiveRecord::Base

  monetize       :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category
  has_many   :reviews

  validates  :name, presence: true
  validates  :price, presence: true, numericality: true
  validates  :quantity, presence: true, numericality: true
  validates  :category, presence: true


  def rating_avg
    reviews.average(:rating)
  end
end
