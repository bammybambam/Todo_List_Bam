class AddDueDateToToDoLists < ActiveRecord::Migration[8.1]
  def change
    add_column :to_do_lists, :due_date, :datetime
  end
end
