require 'test_helper'

class Admin::EntitiesUsersControllerTest < ActionController::TestCase
  setup do
    @admin_entities_user = admin_entities_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_entities_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_entities_user" do
    assert_difference('Admin::EntitiesUser.count') do
      post :create, admin_entities_user: {  }
    end

    assert_redirected_to admin_entities_user_path(assigns(:admin_entities_user))
  end

  test "should show admin_entities_user" do
    get :show, id: @admin_entities_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_entities_user
    assert_response :success
  end

  test "should update admin_entities_user" do
    put :update, id: @admin_entities_user, admin_entities_user: {  }
    assert_redirected_to admin_entities_user_path(assigns(:admin_entities_user))
  end

  test "should destroy admin_entities_user" do
    assert_difference('Admin::EntitiesUser.count', -1) do
      delete :destroy, id: @admin_entities_user
    end

    assert_redirected_to admin_entities_users_path
  end
end
