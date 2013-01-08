require 'test_helper'

class EntityLinksControllerTest < ActionController::TestCase
  setup do
    @entity_link = entity_links(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:entity_links)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create entity_link" do
    assert_difference('EntityLink.count') do
      post :create, entity_link: { entity_id: @entity_link.entity_id, link: @entity_link.link, title: @entity_link.title }
    end

    assert_redirected_to entity_link_path(assigns(:entity_link))
  end

  test "should show entity_link" do
    get :show, id: @entity_link
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @entity_link
    assert_response :success
  end

  test "should update entity_link" do
    put :update, id: @entity_link, entity_link: { entity_id: @entity_link.entity_id, link: @entity_link.link, title: @entity_link.title }
    assert_redirected_to entity_link_path(assigns(:entity_link))
  end

  test "should destroy entity_link" do
    assert_difference('EntityLink.count', -1) do
      delete :destroy, id: @entity_link
    end

    assert_redirected_to entity_links_path
  end
end
