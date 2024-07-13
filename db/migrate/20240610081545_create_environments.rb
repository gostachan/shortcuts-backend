class CreateEnvironments < ActiveRecord::Migration[7.1]
  def change
    create_table :environments do |t|
      t.integer :user_id
      t.string :name

      t.timestamps
    end
  end
end
