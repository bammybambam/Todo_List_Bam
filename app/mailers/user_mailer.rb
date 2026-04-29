class UserMailer < ApplicationMailer
  def task_reminder(user, task)
    @user = user
    @task = task
    puts "Sending reminder email to #{@user.email} for task '#{@task.title}' due on #{@task.due_date.strftime("%d-%m-%Y")}"
    mail(to: @user.email, subject: "Reminder: Task '#{@task.title}' is due soon!")
  end
end
