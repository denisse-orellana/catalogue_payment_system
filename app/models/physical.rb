class Physical < ApplicationRecord
    has_many :images
    has_many :products, as: :category
end
