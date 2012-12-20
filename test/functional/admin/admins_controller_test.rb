require 'test_helper'

class Admin::AdminsControllerTest < ActionController::TestCase
  setup do
    @admin_admin = admin_admins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_admins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_admin" do
    assert_difference('Admin::Admin.count') do
      post :create, admin_admin: { user_id: @admin_admin.user_id }
    end

    assert_redirected_to admin_admin_path(assigns(:admin_admin))
  end

  test "should show admin_admin" do
    get :show, id: @admin_admin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_admin
    assert_response :success
  end

  test "should update admin_admin" do
    put :update, id: @admin_admin, admin_admin: { user_id: @admin_admin.user_id }
    assert_redirected_to admin_admin_path(assigns(:admin_admin))
  end

  test "should destroy admin_admin" do
    assert_difference('Admin::Admin.count', -1) do
      delete :destroy, id: @admin_admin
    end

    assert_redirected_to admin_admins_path
  end
end
