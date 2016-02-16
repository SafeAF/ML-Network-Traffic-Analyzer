require 'test_helper'

class GirlogsControllerTest < ActionController::TestCase
  setup do
    @girlog = girlogs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:girlogs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create girlog" do
    assert_difference('Girlog.count') do
      post :create, girlog: { application: @girlog.application, body: @girlog.body, client: @girlog.client, component: @girlog.component, context: @girlog.context, criticality: @girlog.criticality, db_latency: @girlog.db_latency, desc: @girlog.desc, error: @girlog.error, error_count: @girlog.error_count, facility: @girlog.facility, generated_at: @girlog.generated_at, hostname: @girlog.hostname, http_code: @girlog.http_code, latency: @girlog.latency, name: @girlog.name, originator: @girlog.originator, pid: @girlog.pid, priority: @girlog.priority, program: @girlog.program, query: @girlog.query, query_time: @girlog.query_time, response_code: @girlog.response_code, response_time: @girlog.response_time, rows_count: @girlog.rows_count, user: @girlog.user }
    end

    assert_redirected_to girlog_path(assigns(:girlog))
  end

  test "should show girlog" do
    get :show, id: @girlog
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @girlog
    assert_response :success
  end

  test "should update girlog" do
    patch :update, id: @girlog, girlog: { application: @girlog.application, body: @girlog.body, client: @girlog.client, component: @girlog.component, context: @girlog.context, criticality: @girlog.criticality, db_latency: @girlog.db_latency, desc: @girlog.desc, error: @girlog.error, error_count: @girlog.error_count, facility: @girlog.facility, generated_at: @girlog.generated_at, hostname: @girlog.hostname, http_code: @girlog.http_code, latency: @girlog.latency, name: @girlog.name, originator: @girlog.originator, pid: @girlog.pid, priority: @girlog.priority, program: @girlog.program, query: @girlog.query, query_time: @girlog.query_time, response_code: @girlog.response_code, response_time: @girlog.response_time, rows_count: @girlog.rows_count, user: @girlog.user }
    assert_redirected_to girlog_path(assigns(:girlog))
  end

  test "should destroy girlog" do
    assert_difference('Girlog.count', -1) do
      delete :destroy, id: @girlog
    end

    assert_redirected_to girlogs_path
  end
end
