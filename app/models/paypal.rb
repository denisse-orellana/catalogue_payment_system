class Paypal < ApplicationRecord
    has_many :payments, as: :paymentcategory
end
