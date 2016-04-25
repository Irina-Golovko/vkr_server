class AddUserColumn < ActiveRecord::Migration
  def change
    add_column :courses, :user_id, :integer
    add_column :topics, :user_id, :integer
    add_column :documents, :user_id, :integer
    add_column :images, :user_id, :integer
  end
end
