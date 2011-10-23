class Similarity < ActiveRecord::Base

  belongs_to :request, :class_name => "Request"
  belongs_to :similar_request, :class_name => "Request"
  
end
