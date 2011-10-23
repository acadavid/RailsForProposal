class Request < ActiveRecord::Base
  attr_accessible :name, :start_date, :decision_date, :company, :comment, :filename, :response_time, :status, :average, :file_upload, :similar_request_ids, :characteristics
  
  attr_accessor :file_upload

  validates :name, :uniqueness => true

  has_many :request_sections, :dependent => :destroy
  has_many :sections, :through => :request_sections
  has_many :section_roles, :through => :request_sections
  has_many :similarities, :foreign_key => 'request_id',
  :class_name => 'Similarity'
  has_many :similar_requests, :through => :similarities

  scope :archived, where(:status => "archived")
  
  before_save :save_file
  
  def rated
    self.status != 'pending'
  end
  
  def section(id)
    self.request_sections.find_by_section_id(id)
  end
  
  def users    
    User.where(:id => self.section_roles.inject([]){ |a, s| a << s.user_id } )
  end
  
  def save_file
    return unless self.file_upload
    self.filename = self.file_upload.original_filename
    directory = "public/upload/rfp"
    path = File.join(directory, self.filename)
    File.open(path, "wb") { |f| f.write(self.file_upload.read) }
  end
  
  def update_average
    sum = 0.0
    for section in self.request_sections
      sum += section.average if section.average > 0.0 
    end    
    self.average = sum / self.request_sections.count
    save
  end

  def update_progress
    value = 0
    finished = self.request_sections.select(&:finished).count
    self.completion_percentage = (finished.to_f/self.request_sections.count.to_f)*100.0 unless finished == 0
    save
  end
  
  def finished
    self.request_sections.inject(true){ |res, sec| res &&= sec.finished }
  end

  def archive!
    self.status = "archive"
    save
  end
end
