class ReportsController < ApplicationController

  def index
  end

  def sections_rejection
    @all_sections = {}
    @accepted = {}
    @rejected = {}
    
    Section.all.each do |s|
      @all_sections[s.name] = [] if @all_sections[s.name].nil?
      @rejected[s.name] = [] if @rejected[s.name].nil?
      @accepted[s.name] = [] if @accepted[s.name].nil?
      
      @all_sections[s.name].concat(s.section_roles)
      @rejected[s.name] = s.section_roles.rejected
      @accepted[s.name] = s.section_roles.accepted
    end
  end

  def users_performance
    @users = User.all
  end
  
end
