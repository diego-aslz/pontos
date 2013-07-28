require 'test_helper'

class PeriodsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Period.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Period.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Period.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to period_url(assigns(:period))
  end

  def test_edit
    get :edit, :id => Period.first
    assert_template 'edit'
  end

  def test_update_invalid
    Period.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Period.first
    assert_template 'edit'
  end

  def test_update_valid
    Period.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Period.first
    assert_redirected_to period_url(assigns(:period))
  end

  def test_destroy
    period = Period.first
    delete :destroy, :id => period
    assert_redirected_to periods_url
    assert !Period.exists?(period.id)
  end
end
