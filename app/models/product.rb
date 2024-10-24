class Product < ActiveRecord::Base
  has_paper_trail

  belongs_to :admin
  has_many :categorizations
  has_many :categories, through: :categorizations
  has_many :product_images, as: :imageable
  has_many :purchases
end
