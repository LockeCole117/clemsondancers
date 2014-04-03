class Page < ActiveRecord::Base
  attr_accessible :content, :title, :url, :index

  validates :title, :presence => true, :uniqueness => true, :allow_blank => false
  validates :content, :presence => true, :allow_blank => false
  validates :url, :presence => true, :uniqueness => true, :allow_blank => false
  validate :cannot_unset_the_current_index

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

  def cannot_unset_the_current_index
    if self.index == false and Page.index.id == self.id
      errors.add(:base, "Cannot unset the index page, you can only make another page the index")
    end
  end

  def unset_other_index_flags_if_index
    if self.index?
      Page.index_flag_set.each do |page|
        next if page.id == self.id
        page.update_attribute(:index, false)
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
