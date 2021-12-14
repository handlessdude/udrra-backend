class PostedFile < ApplicationRecord
  validates_presence_of :type,
                        :url
  validates_uniqueness_of :url

  has_many :detail, as: :entity
end
