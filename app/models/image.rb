# An image belongs to a gallery, and a gallery can have many images.
# An image needs both a URL and a description. This is because the images are
# not stored on the server, instead they are stored on a remote image host like
# imgur.com . And the description is used as the alt tag and `figcaption` when
# displaying a gallery for accessibility reasons.

class Image < ActiveRecord::Base
  belongs_to :gallery
  attr_accessible :gallery_id, :description, :url
  validates :url, :presence => true, :allow_blank => false
  validates :description, :presence => true, :allow_blank => false
end
