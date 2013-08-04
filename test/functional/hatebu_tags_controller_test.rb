require 'test_helper'

class HatebuTagsControllerTest < ActionController::TestCase
  setup do
    @hatebu_tag = hatebu_tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hatebu_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hatebu_tag" do
    assert_difference('HatebuTag.count') do
      post :create, hatebu_tag: { cnt: @hatebu_tag.cnt, hatebu_category_id: @hatebu_tag.hatebu_category_id, tag_name: @hatebu_tag.tag_name }
    end

    assert_redirected_to hatebu_tag_path(assigns(:hatebu_tag))
  end

  test "should show hatebu_tag" do
    get :show, id: @hatebu_tag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hatebu_tag
    assert_response :success
  end

  test "should update hatebu_tag" do
    put :update, id: @hatebu_tag, hatebu_tag: { cnt: @hatebu_tag.cnt, hatebu_category_id: @hatebu_tag.hatebu_category_id, tag_name: @hatebu_tag.tag_name }
    assert_redirected_to hatebu_tag_path(assigns(:hatebu_tag))
  end

  test "should destroy hatebu_tag" do
    assert_difference('HatebuTag.count', -1) do
      delete :destroy, id: @hatebu_tag
    end

    assert_redirected_to hatebu_tags_path
  end
end
