class DocTableChange < ActiveRecord::Migration
  def change
    add_column :documents, :topic_id, :integer
    add_index  :documents, :topic_id
  end
end
