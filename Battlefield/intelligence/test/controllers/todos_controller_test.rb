require 'test_helper'

class TodosControllerTest < ActionController::TestCase
  setup do
    @todo = todos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:todos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create todo" do
    assert_difference('Todo.count') do
      post :create, todo: { department_id: @todo.department_id, desc: @todo.desc, details: @todo.details, estimated_manhours: @todo.estimated_manhours, eta: @todo.eta, infrastructure_id: @todo.infrastructure_id, name: @todo.name, operations_id: @todo.operations_id, priority: @todo.priority, project_id: @todo.project_id, ratio_actual_manhours: @todo.ratio_actual_manhours, tasklist_id: @todo.tasklist_id, team_id: @todo.team_id, total_manhours: @todo.total_manhours, user_id: @todo.user_id, username_id: @todo.username_id }
    end

    assert_redirected_to todo_path(assigns(:todo))
  end

  test "should show todo" do
    get :show, id: @todo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @todo
    assert_response :success
  end

  test "should update todo" do
    patch :update, id: @todo, todo: { department_id: @todo.department_id, desc: @todo.desc, details: @todo.details, estimated_manhours: @todo.estimated_manhours, eta: @todo.eta, infrastructure_id: @todo.infrastructure_id, name: @todo.name, operations_id: @todo.operations_id, priority: @todo.priority, project_id: @todo.project_id, ratio_actual_manhours: @todo.ratio_actual_manhours, tasklist_id: @todo.tasklist_id, team_id: @todo.team_id, total_manhours: @todo.total_manhours, user_id: @todo.user_id, username_id: @todo.username_id }
    assert_redirected_to todo_path(assigns(:todo))
  end

  test "should destroy todo" do
    assert_difference('Todo.count', -1) do
      delete :destroy, id: @todo
    end

    assert_redirected_to todos_path
  end
end
