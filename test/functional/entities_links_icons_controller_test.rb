require 'test_helper'

class EntitiesLinksIconsControllerTest < ActionController::TestCase
  setup do
    @entities_links_icon = entities_links_icons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:entities_links_icons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create entities_links_icon" do
    assert_difference('EntitiesLinksIcon.count') do
      post :create, entities_links_icon: { name: @entities_links_icon.name, source: @entities_links_icon.source }
    end

    assert_redirected_to entities_links_icon_path(assigns(:entities_links_icon))
  end

  test "should show entities_links_icon" do
    get :show, id: @entities_links_icon
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @entities_links_icon
    assert_response :success
  end

  test "should update entities_links_icon" do
    put :update, id: @entities_links_icon, entities_links_icon: { name: @entities_links_icon.name, source: @entities_links_icon.source }
    assert_redirected_to entities_links_icon_path(assigns(:entities_links_icon))
  end

  test "should destroy entities_links_icon" do
    assert_difference('EntitiesLinksIcon.count', -1) do
      delete :destroy, id: @entities_links_icon
    end

    assert_redirected_to entities_links_icons_path
  end
end
