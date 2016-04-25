class AddDescriptionAndTextToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :description, :string
    add_column :documents, :text, :string
  end
end
