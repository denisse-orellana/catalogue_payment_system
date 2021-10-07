class Payment < ApplicationRecord
  belongs_to :paymentcategory, polymorphic: true, optional: true
  has_many :orders, dependent: :destroy
end