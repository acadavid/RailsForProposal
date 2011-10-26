class User < ActiveRecord::Base
  acts_as_authentic
  
  attr_accessible :first_name, :last_name, :username, :email, :password, :password_confirmation, :admin

  validates :username, :uniqueness => true

  has_many :section_roles, :dependent => :destroy

  has_many :request_sections, :through => :section_roles, :source => :request_section
  
  def full_name
    "#{first_name} #{last_name}"
  end

  def requests
    self.request_sections.map(&:request).uniq
  end
  
end
