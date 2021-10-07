class Digital < ApplicationRecord
    has_one :image
    has_many :products, as: :category
end
