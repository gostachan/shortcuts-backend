class RenameWhereColumnToConditionInShortcuts < ActiveRecord::Migration[7.1]
  def change
    rename_column :shortcuts, :when, :condition
  end
end
