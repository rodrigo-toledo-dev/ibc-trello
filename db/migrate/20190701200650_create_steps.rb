class CreateSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :steps do |t|
      t.references :board, foreign_key: true
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :steps, :slug, unique: true
  end
end
