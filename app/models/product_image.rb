class ProductImage < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
end
