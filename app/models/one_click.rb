class OneClick < ApplicationRecord
    has_many :transbanks, as: :method
end
