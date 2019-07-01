class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.references :step, foreign_key: true
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :tasks, :slug, unique: true
  end
end
