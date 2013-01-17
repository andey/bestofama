require 'test_helper'

class TrashesControllerTest < ActionController::TestCase
  setup do
    @trash = trashes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trashes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trash" do
    assert_difference('Trash.count') do
      post :create, trash: {key: @trash.key}
    end

    assert_redirected_to trash_path(assigns(:trash))
  end

  test "should show trash" do
    get :show, id: @trash
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trash
    assert_response :success
  end

  test "should update trash" do
    put :update, id: @trash, trash: {key: @trash.key}
    assert_redirected_to trash_path(assigns(:trash))
  end

  test "should destroy trash" do
    assert_difference('Trash.count', -1) do
      delete :destroy, id: @trash
    end

    assert_redirected_to trashes_path
  end
end
