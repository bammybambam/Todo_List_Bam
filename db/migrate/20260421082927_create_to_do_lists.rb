class CreateToDoLists < ActiveRecord::Migration[8.1]
  def change
    create_table :to_do_lists do |t|
      t.string :title
      t.text :desc
      t.boolean :iscomplete

      t.timestamps
    end
  end
end
