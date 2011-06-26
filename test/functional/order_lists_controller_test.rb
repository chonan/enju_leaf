require 'test_helper'

class OrderListsControllerTest < ActionController::TestCase
  fixtures :order_lists, :users, :patrons, :patron_types, :languages, :roles, :library_groups

  def test_guest_should_not_create_order_list
    assert_no_difference('OrderList.count') do
      post :create, :order_list => { :title => 'test' }
    end
    
    assert_redirected_to new_user_session_url
  end

  def test_user_should_not_create_order_list
    sign_in users(:user1)
    assert_no_difference('OrderList.count') do
      post :create, :order_list => { :title => 'test' }
    end
    
    assert_response :forbidden
  end

  def test_librarian_should_not_create_order_list_without_title
    sign_in users(:librarian1)
    assert_no_difference('OrderList.count') do
      post :create, :order_list => { }
    end
    
    assert_response :success
  end

  def test_librarian_should_create_order_list_without_bookstore_id
    sign_in users(:librarian1)
    assert_no_difference('OrderList.count') do
      post :create, :order_list => { :title => 'test' }
    end
    
    assert_response :success
  end

  def test_librarian_should_create_order_list_with_bookstore_id
    sign_in users(:librarian1)
    assert_difference('OrderList.count') do
      post :create, :order_list => { :title => 'test', :bookstore_id => 1 }
    end
    
    assert_redirected_to order_list_url(assigns(:order_list))
  end

  def test_admin_should_create_order_list
    sign_in users(:admin)
    assert_difference('OrderList.count') do
      post :create, :order_list => { :title => 'test', :bookstore_id => 1 }
    end
    
    assert_redirected_to order_list_url(assigns(:order_list))
  end

  def test_guest_should_not_update_order_list
    put :update, :id => 1, :order_list => { }
    assert_redirected_to new_user_session_url
  end
  
  def test_user_should_not_update_order_list
    sign_in users(:user1)
    put :update, :id => 1, :order_list => { }
    assert_response :forbidden
  end
  
  def test_librarian_should_not_update_order_list_without_title
    sign_in users(:librarian1)
    put :update, :id => 1, :order_list => {:title => ""}
    assert_response :success
  end
  
  def test_librarian_should_update_order_list
    sign_in users(:librarian1)
    put :update, :id => 1, :order_list => { }
    assert_redirected_to order_list_url(assigns(:order_list))
  end
  
  def test_admin_should_update_order_list
    sign_in users(:admin)
    put :update, :id => 1, :order_list => { }
    assert_redirected_to order_list_url(assigns(:order_list))
  end
  
  def test_guest_should_not_destroy_order_list
    assert_no_difference('OrderList.count') do
      delete :destroy, :id => 1
    end
    
    assert_redirected_to new_user_session_url
  end

  def test_user_should_not_destroy_order_list
    sign_in users(:user1)
    assert_no_difference('OrderList.count') do
      delete :destroy, :id => 1
    end
    
    assert_response :forbidden
  end

  def test_librarian_should_destroy_order_list
    sign_in users(:librarian1)
    assert_difference('OrderList.count', -1) do
      delete :destroy, :id => 1
    end
    
    assert_redirected_to order_lists_url
  end

  def test_admin_should_destroy_order_list
    sign_in users(:admin)
    assert_difference('OrderList.count', -1) do
      delete :destroy, :id => 1
    end
    
    assert_redirected_to order_lists_url
  end
end
