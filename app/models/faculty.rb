class Faculty < ApplicationRecord
  validates_presence_of :faculty
  has_many :users
end
