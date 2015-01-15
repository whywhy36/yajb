class Type < ActiveRecord::Base
  has_many :jobs

  def to_param
    "#{id} #{name}".parameterize
  end
end
