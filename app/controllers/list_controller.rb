class ListController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :select_list, only: [ :update, :destroy, :checklist ]

def profile
end

def index
  if params[:query].present?
    @todo_list = ToDoList.where("title LIKE ?", "%#{params[:query]}%")
  else
    @todo_list = ToDoList.order(:id)
  end
end


def create
  if request.post?
    @todo_list_new = ToDoList.new(select_params)
    if @todo_list_new.save
      redirect_to root_path, status: :see_other
    else
      render :create, status: :unprocessable_entity
    end
  else
    @todo_list_new = ToDoList.new
  end
end

def update
  if @todo_list_select.update(select_params)
    redirect_to root_path, status: :see_other
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
      format.html { redirect_back fallback_location: root_path }
    end
  else
    head :unprocessable_entity
  end
end

def destroy
  @todo_list_select.destroy
  respond_to do |format|
    format.html { redirect_to root_path, status: :see_other }
  end
end

private
def select_list
  @todo_list_select = ToDoList.find(params[:id])
end

def select_params
  params.require(:list).permit(:title, :desc, :iscomplete)
end
end
