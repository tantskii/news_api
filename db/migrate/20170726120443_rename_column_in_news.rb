class RenameColumnInNews < ActiveRecord::Migration[5.0]
  def change
    rename_column :news, :сontent, :content
  end
end
