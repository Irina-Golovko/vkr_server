class RemoveTextColumnFromDocuments < ActiveRecord::Migration
  def change
    remove_column :documents, :text
  end
end
