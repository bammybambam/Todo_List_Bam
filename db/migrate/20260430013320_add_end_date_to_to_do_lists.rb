class AddEndDateToToDoLists < ActiveRecord::Migration[8.1]
  def change
    add_column :to_do_lists, :end_date, :datetime
  end
end
