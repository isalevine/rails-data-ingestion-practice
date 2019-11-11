class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.string :uuid
      t.string :name
      t.integer :hp
      t.string :magic

      t.timestamps
    end
  end
end
