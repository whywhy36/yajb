class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orgs

  def admin?
    id == 1
  end

  def normal_user?
    !id.nil? 
  end

  def bind_org?
    !orgs.empty?
  end
end
