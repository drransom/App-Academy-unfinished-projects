class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :article
  has_many :taggings
end
