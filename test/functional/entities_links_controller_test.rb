require 'test_helper'

class EntitiesLinksControllerTest < ActionController::TestCase
  setup do
    @entities_link = entities_links(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:entities_links)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create entities_link" do
    assert_difference('EntitiesLink.count') do
      post :create, entities_link: { entity_id: @entities_link.entity_id, link: @entities_link.link, title: @entities_link.title }
    end

    assert_redirected_to entities_link_path(assigns(:entities_link))
  end

  test "should show entities_link" do
    get :show, id: @entities_link
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @entities_link
    assert_response :success
  end

  test "should update entities_link" do
    put :update, id: @entities_link, entities_link: { entity_id: @entities_link.entity_id, link: @entities_link.link, title: @entities_link.title }
    assert_redirected_to entities_link_path(assigns(:entities_link))
  end

  test "should destroy entities_link" do
    assert_difference('EntitiesLink.count', -1) do
      delete :destroy, id: @entities_link
    end

    assert_redirected_to entities_links_path
  end
end
