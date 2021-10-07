class Product < ApplicationRecord
  # has_many_attached :images // Before the models added
  belongs_to :category, polymorphic: true
end
