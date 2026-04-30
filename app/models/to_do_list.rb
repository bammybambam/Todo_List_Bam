# == Schema Information
#
# Table name: to_do_lists
#
#  id         :bigint           not null, primary key
#  desc       :text
#  due_date   :datetime
#  end_date   :datetime
#  iscomplete :boolean
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_to_do_lists_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class ToDoList < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :due_date, presence: true

  before_create :set_iscomple_false, :set_end_date

  def set_iscomple_false
    self.iscomplete = false
  end

  def set_end_date
    if self.end_date.nil?
      self.end_date = self.due_date
    end
  end
end
