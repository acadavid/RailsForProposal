class KnowledgeBaseController < ApplicationController

  def index
    @requests = Request.archived
  end
  
end
