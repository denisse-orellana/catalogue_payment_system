class Order < ApplicationRecord
  belongs_to :payment

  accepts_nested_attributes_for :payment, reject_if: :all_blank, allow_destroy: true
end
