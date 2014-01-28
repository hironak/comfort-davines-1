class Payment < ActiveRecord::Base
  self.table_name_prefix = 'payment_'
  self.abstract_class = true

  has_one :order

  TYPES = ['Payment::Creditcard']
end
