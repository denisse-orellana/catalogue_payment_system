class Webpay < ApplicationRecord
    has_many :transbanks, as: :method
end
