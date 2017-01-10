class Link < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true
  validates_format_of :url, with: URI::regexp

  belongs_to :user

  def is_read?
    read
  end
end
