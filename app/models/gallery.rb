class Gallery < ActiveRecord::Base
  has_many :images
  attr_accessible :images_attributes, :description, :title
  accepts_nested_attributes_for :images, allow_destroy: true
  validates_associated :images
  validates :images, :presence => true

  validates :title, :presence => true, :uniqueness => true, :allow_blank => false
end
