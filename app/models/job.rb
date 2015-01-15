class Job < ActiveRecord::Base
  scope :open,    -> { where(status: 'open') }
  scope :closed,  -> { where(status: 'closed') }

  self.per_page = 3

  validates :title, :presence => true
  validates :jd, :presence => true

  belongs_to :category
  validates :category, :presence =>true

  belongs_to :type
  validates :type, :presence => true
  
  belongs_to :org
  validates :org, :presence => true

  def open?
    status == 'open'
  end

  def closed?
    status == 'closed'
  end

  def to_param
    "#{id}-#{title}-#{org.name}".parameterize
  end
end
