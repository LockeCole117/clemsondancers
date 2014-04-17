# A gallery is a collection of images (meaning, there are many images
# in a gallery). The images associated with a gallery are directly manipulated
# at the same time by using Rails' nested attributes feature.
# You can view more about that here:
# http://railscasts.com/episodes/196-nested-model-form-part-1
#
# Note that galleries themselves have a tile and a description.

class Gallery < ActiveRecord::Base
  has_many :images
  attr_accessible :images_attributes, :description, :title
  accepts_nested_attributes_for :images, allow_destroy: true
  validates_associated :images
  validates :images, :presence => true

  validates :title, :presence => true, :uniqueness => true, :allow_blank => false
end
