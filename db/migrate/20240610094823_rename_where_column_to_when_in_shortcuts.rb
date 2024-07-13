class RenameWhereColumnToWhenInShortcuts < ActiveRecord::Migration[7.1]
  def change
    rename_column :shortcuts, :where, :when
  end
end
