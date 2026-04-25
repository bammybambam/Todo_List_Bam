# == Schema Information
#
# Table name: to_do_lists
#
#  id         :bigint           not null, primary key
#  desc       :text
#  iscomplete :boolean
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ToDoList < ApplicationRecord
  validates :title, presence: true

  before_create :set_iscomple_false

  def set_iscomple_false
    self.iscomplete = false
  end
end
