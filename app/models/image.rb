class Image < ActiveRecord::Base
  belongs_to :gallery
  attr_accessible :gallery_id, :description, :url
end
