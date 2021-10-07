class CreditCard < ApplicationRecord
    has_many :transbanks, as: :method
end
