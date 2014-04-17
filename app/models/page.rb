# Pages are the backbone of the site. Pages are made up of a title, URL, and the content
# The title is used to generate the URL, but in the future the url could be generated automatically
# The title and the URL must both be unique, otherwise we cannot tell which page to load
# The content of the site is stored as Markdown, which is rendered by a view helper when the page is displayed
#
# Only one page can be designated as the "home" page for the entire website. The "home" page cannot
# "step down" from being the home page, only another page can be designated as the new "home" page

class Page < ActiveRecord::Base
  attr_accessible :content, :title, :url, :index
  PROTECTED_URLS = ["superuser", "gallery", "admin"]

  validates :title, :presence => true, :uniqueness => true, :allow_blank => false
  validates :content, :presence => true, :allow_blank => false
  validates :url, :presence => true, :uniqueness => true, :allow_blank => false
  validate :cannot_unset_the_current_index

  validate :reserved_url
  validate :reserved_title

  after_destroy :set_first_page_as_index_if_index

  # Checks the list of protected URLs for a match with the current URL
  # if there is a match, the record is invalid
  def reserved_url
    return unless self.url.present?

    PROTECTED_URLS.each do |reserved_url|
      self.errors.add(:url, "is reserved") if self.url.downcase == reserved_url
    end
  end

  # Checks the list of protected URLs and compares it against the downcased version of the title
  # Since the url is derived from the title, a title that matches a "reserved" url would break the site
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
  scope :ordered, :order => "`index` DESC"


  # This allows us to quickly find the index page anywhere throughout the application,
  # just by calling: Page.first
  def self.index
    Page.index_flag_set.first
  end


  # Basic helper methods to make it easier to flag a page as the new "home" page
  def mark_as_index
    self.index = true
  end

  def mark_as_index!
    self.mark_as_index
    self.save!
  end

  protected

  # This prevents the current home page from "stepping down"
  def cannot_unset_the_current_index
    if self.index == false and Page.index.id == self.id
      errors.add(:base, "Cannot unset the index page, you can only make another page the index")
    end
  end

  # Finds every other page that has the index flag set (besides this one) and unsets them.
  # This ensures that there's only one possible "home" page
  def unset_other_index_flags_if_index
    if self.index?
      Page.index_flag_set.each do |page|
        next if page.id == self.id
        page.update_attribute(:index, false)
      end
    end
  end

  # If there are no pages in the site, or this is the only page, then it's automatically the "home" page
  # Therefore it cannot "step down" until another page is created
  def set_page_to_index_if_no_other_pages_exist
    if Page.count == 0 or (Page.count == 1 and Page.first.id == self.id)
      self.index = true
    end
  end

  # If the home page is destroyed, quickly assign the first page we find as the index.
  # This will prevent the site breaking for the end uses.
  def set_first_page_as_index_if_index
    if self.index?
      Page.first.update_attribute(:index, true) unless Page.first.nil?
    end
  end

  # Page URLs are based on the title of the page. Therefore, we generate a new
  # URL for the page if it doesn't exist or it was previously set to the page's title
  def generate_url
    self.url = self.title.parameterize.underscore if self.url.blank?
  end
end
