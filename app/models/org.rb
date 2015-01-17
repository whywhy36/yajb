class Org < ActiveRecord::Base
  has_many :jobs

  self.per_page = 15

  def to_param
    "#{id} #{name}".parameterize
  end
end
