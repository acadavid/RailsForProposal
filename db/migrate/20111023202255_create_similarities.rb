class CreateSimilarities < ActiveRecord::Migration
  def self.up
    create_table :similarities do |t|
      t.integer :request_id
      t.integer :similar_request_id
      t.timestamps
    end
  end

  def self.down
    drop_table :similarities
  end
end
