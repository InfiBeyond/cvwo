class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /tasks or /tasks.json
  def index
    @tasks = Task.select{|t| t.user == current_user}
    complete = (Task.where({is_complete: true}).count).to_f
    all = (Task.all.count).to_f - 1
    @percentage = complete/all*100

  end
  
  def incomplete
    @incomplete_tasks = Task.where({is_complete: false})
  end

  def due
    date = Date.today
    week_later_date = date + 7
    @due_tasks = Task.where({due_date: (date..week_later_date)})
  end

  def overdue
    tasks = Task.select{|t| t.user == current_user}
    date = Date.today
    @overdue_tasks = Task.where("due_date < ?", date)
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to root_path, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to root_path, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to request.referer, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description, :is_complete, :due_date, :user_id, :category_ids=>[])
    end
end
