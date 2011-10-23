class AddFieldsToRequest < ActiveRecord::Migration
  def self.up
    add_column :requests, :completion_percentage, :float, :default => 0.0
    add_column :requests, :feedback, :text
    add_column :requests, :characteristics, :text
  end

  def self.down
    remove_column :requests, :completion_percentage
    remove_column :requests, :feedback
    remove_column :requests, :characteristics
  end
end
