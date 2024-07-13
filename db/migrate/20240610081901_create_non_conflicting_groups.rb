class CreateNonConflictingGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :non_conflicting_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
