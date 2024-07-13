class CreateShortcuts < ActiveRecord::Migration[7.1]
  def change
    create_table :shortcuts do |t|
      t.integer :environment_id
      t.string :command
      t.string :key_binding
      t.string :where
      t.boolean :favorite

      t.timestamps
    end
  end
end
