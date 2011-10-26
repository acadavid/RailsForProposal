class Section < ActiveRecord::Base
  
  validates :name, :presence => true
  validates :name, :uniqueness => true

  has_many :request_sections
  has_many :section_roles, :through => :request_sections
  
end
