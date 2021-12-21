class Role < ApplicationRecord
  validates_presence_of :role_name
  validates_uniqueness_of :role_name

  has_and_belongs_to_many :users
  before_destroy { users.clear }
end
