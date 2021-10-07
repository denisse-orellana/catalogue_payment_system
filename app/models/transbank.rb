class Transbank < ApplicationRecord
  belongs_to :method, polymorphic: true

  has_many :payments, as: :paymentcategory
end
