class Payment < ActiveRecord::Base
  self.table_name_prefix = 'payment_'
  self.abstract_class = true

  has_one :order

  TYPES = {
    'クレジットカード' => 'Payment::Creditcard',
    '後払い'           => 'Payment::Deferred'
    '代金引換'         => 'Payment::Collect'
  }
end
