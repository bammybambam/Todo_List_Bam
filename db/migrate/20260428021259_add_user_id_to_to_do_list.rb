class AddUserIdToToDoList < ActiveRecord::Migration[8.1]
  def change
    add_reference :to_do_lists, :user, null: true, foreign_key: true
  end
end
