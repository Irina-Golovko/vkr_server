class AddTextColumnToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :text, :string
  end
end
