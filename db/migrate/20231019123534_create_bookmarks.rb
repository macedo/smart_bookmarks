class CreateBookmarks < ActiveRecord::Migration[7.1]
  def change
    create_table :bookmarks do |t|
      t.string :link, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
