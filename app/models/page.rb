class Page < ActiveRecord::Base
  attr_accessible :content, :title, :url

  validates :title, :presence => true, :uniqueness => true, :allow_blank => false
  validates :content, :presence => true, :allow_blank => false
  validates :url, :presence => true, :uniqueness => true, :allow_blank => false

  before_validation :generate_url

  protected

  def generate_url
    self.url = self.title.parameterize.underscore if self.url.blank?
  end
end
