class ChangeUrlColumn < ActiveRecord::Migration
  def change
    rename_column :images, :url, :file
  end
end
