class Page < ActiveRecord::Base
  attr_accessible :content, :title

  validates :title, :presence => true, :uniqueness => true, :allow_blank => false
  validates :content, :presence => true, :allow_blank => false
end
