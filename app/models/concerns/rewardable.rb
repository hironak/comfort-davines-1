module Rewardable
  extend ActiveSupport::Concern

  included do
    reward_records_as :orders
  end

  module ClassMethods
    def reward_records_as records
      @@reward_records = records
    end

    def reward_records
      @@reward_records
    end
  end

  def reward
    reward_records.map{|o| o.backmargin(self.class.name.underscore) }.inject(:+)
  end

  def reward_records
    send(self.class.reward_records)
  end
end
