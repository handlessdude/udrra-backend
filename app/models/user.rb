class User < ApplicationRecord
  validates_presence_of :login,
                        :encrypted_password,
                        :first_name,
                        :second_name
  has_and_belongs_to_many :notifications
  belongs_to :faculty
end
