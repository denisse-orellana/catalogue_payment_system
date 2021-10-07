class Stripe < ApplicationRecord
    has_many :payments, as: :paymentcategory
end
