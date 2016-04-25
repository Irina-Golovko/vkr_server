class TopicTableChange < ActiveRecord::Migration
  def change
    add_column :topics, :title, :string
    add_column :topics, :course_id, :integer 
    add_index  :topics, :course_id
  end
end
