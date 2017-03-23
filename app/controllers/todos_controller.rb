class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]
  before_action :set_request

  # GET /todos
  def index
    @todos = Todo.all
    json_response(@todos)
  end

  # POST /todos
  def create
    @todo = Todo.create!(todo_params)
    json_response(@todo, :created)
  end

  # DELETE /
  def destroy_all
    Todo.destroy_all
    head :no_content
  end

  # GET /:id
  def show
    json_response(@todo)
  end

  # PATCH /:id
  def update
    @todo.update_attributes(todo_params)
    json_response(@todo)
  end

  # DELETE /:id
  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def todo_params
    # whitelist params
    params.permit(:title, :order, :completed)
  end

  def set_request
    $request = request
  end

  def set_todo
    @todo = Todo.find(params[:id])
  end
end
