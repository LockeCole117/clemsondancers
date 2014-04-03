class Page < ActiveRecord::Base
  attr_accessible :content, :title, :url, :index
  PROTECTED_URLS = ["superuser", "gallery", "admin"]

  validates :title, :presence => true, :uniqueness => true, :allow_blank => false
  validates :content, :presence => true, :allow_blank => false
  validates :url, :presence => true, :uniqueness => true, :allow_blank => false

  validate :reserved_url
  validate :reserved_title

  def reserved_url
    return unless self.url.present?

    PROTECTED_URLS.each do |reserved_url|
      self.errors.add(:url, "is reserved") if self.url.downcase == reserved_url
    end
  end

  def reserved_title
    return unless self.title.present?
    
    PROTECTED_URLS.each do |reserved_title|
      self.errors.add(:title, "is reserved") if self.title.downcase == reserved_title
    end
  end
 

  before_validation :generate_url
  before_save :unset_other_index_flags_if_index
  before_save :set_page_to_index_if_no_other_pages_exist

  scope :index_flag_set, :conditions => {:index => true}

  def self.index
    Page.index_flag_set.first
  end

  def mark_as_index
    self.index = true
  end

  def mark_as_index!
    self.mark_as_index
    self.save!
  end

  protected

  def unset_other_index_flags_if_index
    if self.index?
      Page.index_flag_set.each do |page|
        next if page.id == self.id
        page.index = false
        page.save!
      end
    end
  end

  def set_page_to_index_if_no_other_pages_exist
    if Page.count == 0 or (Page.count == 1 and Page.first.id == self.id)
      self.index = true
    end
  end

  def generate_url
    self.url = self.title.parameterize.underscore if self.url.blank?
  end
end
