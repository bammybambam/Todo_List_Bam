# == Schema Information
#
# Table name: to_do_lists
#
#  id         :bigint           not null, primary key
#  desc       :text
#  due_date   :datetime
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
require "test_helper"

class ToDoListTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
