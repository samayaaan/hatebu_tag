require 'test_helper'

class HatebuCategoriesControllerTest < ActionController::TestCase
  setup do
    @hatebu_category = hatebu_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hatebu_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hatebu_category" do
    assert_difference('HatebuCategory.count') do
      post :create, hatebu_category: { name: @hatebu_category.name, url: @hatebu_category.url }
    end

    assert_redirected_to hatebu_category_path(assigns(:hatebu_category))
  end

  test "should show hatebu_category" do
    get :show, id: @hatebu_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hatebu_category
    assert_response :success
  end

  test "should update hatebu_category" do
    put :update, id: @hatebu_category, hatebu_category: { name: @hatebu_category.name, url: @hatebu_category.url }
    assert_redirected_to hatebu_category_path(assigns(:hatebu_category))
  end

  test "should destroy hatebu_category" do
    assert_difference('HatebuCategory.count', -1) do
      delete :destroy, id: @hatebu_category
    end

    assert_redirected_to hatebu_categories_path
  end
end
