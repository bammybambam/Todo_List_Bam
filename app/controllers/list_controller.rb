class ListController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :authenticate_user!
  before_action :select_list, only: [ :update, :destroy, :checklist ]

def profile
  @user = User.find_by(id: session[:user_id])
end

def index
  if params[:query].present?
    @todo_list = ToDoList.where(user_id: current_user.id).where("title ILIKE ?", "%#{params[:query]}%").order(:id)
  else
    @todo_list = ToDoList.where(user_id: current_user.id).order(:id)
  end
end


def create
  if request.post?
    @todo_list_new = ToDoList.new(select_params)
    @todo_list_new.user_id = current_user.id
    if @todo_list_new.save
      redirect_to list_index_path, status: :see_other
    else
      render :create, status: :unprocessable_entity
    end
  else
    @todo_list_new = ToDoList.new
  end
end

def update
  if @todo_list_select.update(select_params)
    redirect_to list_index_path, status: :see_other
  else
    render :index, status: :unprocessable_entity
  end
end

def checklist
  if @todo_list_select.update(select_params)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          dom_id(@todo_list_select),
          partial: "shared/list_card",
          locals: { todo_list: @todo_list_select })
      end
      format.html { redirect_back fallback_location: list_index_path }
    end
  else
    head :unprocessable_entity
  end
end

def destroy
  @todo_list_select.destroy
  respond_to do |format|
    format.html { redirect_to list_index_path, status: :see_other }
  end
end

def calendar
  @tasks = ToDoList.where(user_id: current_user.id)

  cal = Icalendar::Calendar.new

  @tasks.each do |task|
    cal.event do |e|
      e.dtstart     = Icalendar::Values::Date.new(task.due_date)
      e.summary     = task.title
      e.description = task.desc
      e.ip_class    = "PRIVATE"
    end
  end

  cal.publish

  respond_to do |format|
    format.ics { render plain: cal.to_ical }
  end
end

private
def select_list
  @todo_list_select = ToDoList.find(params[:id])
end

def select_params
  params.require(:list).permit(:title, :desc, :iscomplete, :due_date)
end
end
