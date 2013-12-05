class AdminRole < ActiveRecord::Base
  has_and_belongs_to_many :dealers, :join_table => :dealers_admin_roles
  belongs_to :resource, :polymorphic => true
  
  scopify
end
