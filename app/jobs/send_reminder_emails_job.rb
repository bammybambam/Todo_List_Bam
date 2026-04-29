class SendReminderEmailsJob < ApplicationJob
  queue_as :default

 def perform
  tasks = ToDoList.where(due_date: Date.tomorrow)
  puts "Found #{tasks.count} tasks due tomorrow."

  tasks.each do |task|
    user = task.user
    UserMailer.task_reminder(user, task).deliver_now
  end
  end
end
