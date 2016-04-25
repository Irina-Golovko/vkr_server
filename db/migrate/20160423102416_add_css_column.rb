class AddCssColumn < ActiveRecord::Migration
  def change
    add_column :documents, :css, :string
  end
end
