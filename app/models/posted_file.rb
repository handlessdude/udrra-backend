class PostedFile < ApplicationRecord
  validates_presence_of :type,
                        :url
  belongs_to :detail, as: :entity
end
