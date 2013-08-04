require 'test_helper'

class HatebuEidsControllerTest < ActionController::TestCase
  setup do
    @hatebu_eid = hatebu_eids(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hatebu_eids)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hatebu_eid" do
    assert_difference('HatebuEid.count') do
      post :create, hatebu_eid: { eid: @hatebu_eid.eid, hatebu_category_id: @hatebu_eid.hatebu_category_id }
    end

    assert_redirected_to hatebu_eid_path(assigns(:hatebu_eid))
  end

  test "should show hatebu_eid" do
    get :show, id: @hatebu_eid
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hatebu_eid
    assert_response :success
  end

  test "should update hatebu_eid" do
    put :update, id: @hatebu_eid, hatebu_eid: { eid: @hatebu_eid.eid, hatebu_category_id: @hatebu_eid.hatebu_category_id }
    assert_redirected_to hatebu_eid_path(assigns(:hatebu_eid))
  end

  test "should destroy hatebu_eid" do
    assert_difference('HatebuEid.count', -1) do
      delete :destroy, id: @hatebu_eid
    end

    assert_redirected_to hatebu_eids_path
  end
end
