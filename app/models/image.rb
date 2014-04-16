class Image < ActiveRecord::Base
  belongs_to :gallery
  attr_accessible :gallery_id, :description, :url
  validates :url, :presence => true, :allow_blank => false
  validates :description, :presence => true, :allow_blank => false
end
