class CreateNews < ActiveRecord::Migration[5.0]
  def change
    create_table :news do |t|
      t.date :date
      t.datetime :datetime
      t.text :сontent
      t.string :sources
      t.string :title

      t.timestamps
    end
  end
end
