class Category < ActiveRecord::Base
  has_paper_trail

  belongs_to :admin
  has_many :categorizations
  has_many :products, through: :categorizations
end
