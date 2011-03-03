require 'spec_helper'
require 'sunspot/rails/spec_helper'

describe ManifestationCheckoutStatsController do
  fixtures :all
  disconnect_sunspot

  describe "GET index" do
    before(:each) do
      Factory.create(:manifestation_checkout_stat)
    end

    describe "When logged in as Administrator" do
      before(:each) do
        sign_in Factory(:admin)
      end

      it "assigns all manifestation_checkout_stats as @manifestation_checkout_stats" do
        get :index
        assigns(:manifestation_checkout_stats).should eq(ManifestationCheckoutStat.all)
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in Factory(:librarian)
      end

      it "assigns all manifestation_checkout_stats as @manifestation_checkout_stats" do
        get :index
        assigns(:manifestation_checkout_stats).should eq(ManifestationCheckoutStat.all)
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in Factory(:user)
      end

      it "assigns all manifestation_checkout_stats as @manifestation_checkout_stats" do
        get :index
        assigns(:manifestation_checkout_stats).should eq(ManifestationCheckoutStat.all)
      end
    end

    describe "When not logged in" do
      it "should not assign manifestation_checkout_stats as @manifestation_checkout_stats" do
        get :index
        assigns(:manifestation_checkout_stats).should eq(ManifestationCheckoutStat.all)
      end
    end
  end

  describe "GET show" do
    describe "When logged in as Administrator" do
      before(:each) do
        sign_in Factory(:admin)
      end

      it "assigns the requested manifestation_checkout_stat as @manifestation_checkout_stat" do
        manifestation_checkout_stat = Factory.create(:manifestation_checkout_stat)
        get :show, :id => manifestation_checkout_stat.id
        assigns(:manifestation_checkout_stat).should eq(manifestation_checkout_stat)
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in Factory(:librarian)
      end

      it "assigns the requested manifestation_checkout_stat as @manifestation_checkout_stat" do
        manifestation_checkout_stat = Factory.create(:manifestation_checkout_stat)
        get :show, :id => manifestation_checkout_stat.id
        assigns(:manifestation_checkout_stat).should eq(manifestation_checkout_stat)
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in Factory(:user)
      end

      it "assigns the requested manifestation_checkout_stat as @manifestation_checkout_stat" do
        manifestation_checkout_stat = Factory.create(:manifestation_checkout_stat)
        get :show, :id => manifestation_checkout_stat.id
        assigns(:manifestation_checkout_stat).should eq(manifestation_checkout_stat)
      end
    end

    describe "When not logged in" do
      it "assigns the requested manifestation_checkout_stat as @manifestation_checkout_stat" do
        manifestation_checkout_stat = Factory.create(:manifestation_checkout_stat)
        get :show, :id => manifestation_checkout_stat.id
        assigns(:manifestation_checkout_stat).should eq(manifestation_checkout_stat)
      end
    end
  end

  describe "GET new" do
    describe "When logged in as Administrator" do
      before(:each) do
        sign_in Factory(:admin)
      end

      it "assigns the requested manifestation_checkout_stat as @manifestation_checkout_stat" do
        get :new
        assigns(:manifestation_checkout_stat).should_not be_valid
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in Factory(:librarian)
      end

      it "assigns the requested manifestation_checkout_stat as @manifestation_checkout_stat" do
        get :new
        assigns(:manifestation_checkout_stat).should_not be_valid
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in Factory(:user)
      end

      it "should not assign the requested manifestation_checkout_stat as @manifestation_checkout_stat" do
        get :new
        assigns(:manifestation_checkout_stat).should_not be_valid
        response.should be_forbidden
      end
    end

    describe "When not logged in" do
      it "should not assign the requested manifestation_checkout_stat as @manifestation_checkout_stat" do
        get :new
        assigns(:manifestation_checkout_stat).should_not be_valid
        response.should redirect_to(new_user_session_url)
      end
    end
  end

  describe "GET edit" do
    describe "When logged in as Administrator" do
      before(:each) do
        sign_in Factory(:admin)
      end

      it "assigns the requested manifestation_checkout_stat as @manifestation_checkout_stat" do
        manifestation_checkout_stat = Factory.create(:manifestation_checkout_stat)
        get :edit, :id => manifestation_checkout_stat.id
        assigns(:manifestation_checkout_stat).should eq(manifestation_checkout_stat)
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in Factory(:librarian)
      end

      it "assigns the requested manifestation_checkout_stat as @manifestation_checkout_stat" do
        manifestation_checkout_stat = Factory.create(:manifestation_checkout_stat)
        get :edit, :id => manifestation_checkout_stat.id
        assigns(:manifestation_checkout_stat).should eq(manifestation_checkout_stat)
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in Factory(:user)
      end

      it "assigns the requested manifestation_checkout_stat as @manifestation_checkout_stat" do
        manifestation_checkout_stat = Factory.create(:manifestation_checkout_stat)
        get :edit, :id => manifestation_checkout_stat.id
        response.should be_forbidden
      end
    end

    describe "When not logged in" do
      it "should not assign the requested manifestation_checkout_stat as @manifestation_checkout_stat" do
        manifestation_checkout_stat = Factory.create(:manifestation_checkout_stat)
        get :edit, :id => manifestation_checkout_stat.id
        response.should redirect_to(new_user_session_url)
      end
    end
  end

  describe "POST create" do
    before(:each) do
      @attrs = Factory.attributes_for(:manifestation_checkout_stat)
      @invalid_attrs = {:start_date => ''}
    end

    describe "When logged in as Administrator" do
      before(:each) do
        sign_in Factory(:admin)
      end

      describe "with valid params" do
        it "assigns a newly created manifestation_checkout_stat as @manifestation_checkout_stat" do
          post :create, :manifestation_checkout_stat => @attrs
          assigns(:manifestation_checkout_stat).should be_valid
        end

        it "redirects to the created manifestation_checkout_stat" do
          post :create, :manifestation_checkout_stat => @attrs
          response.should redirect_to(manifestation_checkout_stat_url(assigns(:manifestation_checkout_stat)))
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved manifestation_checkout_stat as @manifestation_checkout_stat" do
          post :create, :manifestation_checkout_stat => @invalid_attrs
          assigns(:manifestation_checkout_stat).should_not be_valid
        end

        it "re-renders the 'new' template" do
          post :create, :manifestation_checkout_stat => @invalid_attrs
          response.should render_template("new")
        end
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in Factory(:librarian)
      end

      describe "with valid params" do
        it "assigns a newly created manifestation_checkout_stat as @manifestation_checkout_stat" do
          post :create, :manifestation_checkout_stat => @attrs
          assigns(:manifestation_checkout_stat).should be_valid
        end

        it "redirects to the created manifestation_checkout_stat" do
          post :create, :manifestation_checkout_stat => @attrs
          response.should redirect_to(manifestation_checkout_stat_url(assigns(:manifestation_checkout_stat)))
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved manifestation_checkout_stat as @manifestation_checkout_stat" do
          post :create, :manifestation_checkout_stat => @invalid_attrs
          assigns(:manifestation_checkout_stat).should_not be_valid
        end

        it "re-renders the 'new' template" do
          post :create, :manifestation_checkout_stat => @invalid_attrs
          response.should render_template("new")
        end
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in Factory(:user)
      end

      describe "with valid params" do
        it "assigns a newly created manifestation_checkout_stat as @manifestation_checkout_stat" do
          post :create, :manifestation_checkout_stat => @attrs
          assigns(:manifestation_checkout_stat).should be_valid
        end

        it "should be forbidden" do
          post :create, :manifestation_checkout_stat => @attrs
          response.should be_forbidden
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved manifestation_checkout_stat as @manifestation_checkout_stat" do
          post :create, :manifestation_checkout_stat => @invalid_attrs
          assigns(:manifestation_checkout_stat).should_not be_valid
        end

        it "should be forbidden" do
          post :create, :manifestation_checkout_stat => @invalid_attrs
          response.should be_forbidden
        end
      end
    end

    describe "When not logged in" do
      describe "with valid params" do
        it "assigns a newly created manifestation_checkout_stat as @manifestation_checkout_stat" do
          post :create, :manifestation_checkout_stat => @attrs
          assigns(:manifestation_checkout_stat).should be_valid
        end

        it "should be forbidden" do
          post :create, :manifestation_checkout_stat => @attrs
          response.should redirect_to(new_user_session_url)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved manifestation_checkout_stat as @manifestation_checkout_stat" do
          post :create, :manifestation_checkout_stat => @invalid_attrs
          assigns(:manifestation_checkout_stat).should_not be_valid
        end

        it "should be forbidden" do
          post :create, :manifestation_checkout_stat => @invalid_attrs
          response.should redirect_to(new_user_session_url)
        end
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      @manifestation_checkout_stat = Factory(:manifestation_checkout_stat)
      @attrs = Factory.attributes_for(:manifestation_checkout_stat)
      @invalid_attrs = {:start_date => ''}
    end

    describe "When logged in as Administrator" do
      before(:each) do
        sign_in Factory(:admin)
      end

      describe "with valid params" do
        it "updates the requested manifestation_checkout_stat" do
          put :update, :id => @manifestation_checkout_stat.id, :manifestation_checkout_stat => @attrs
        end

        it "assigns the requested manifestation_checkout_stat as @manifestation_checkout_stat" do
          put :update, :id => @manifestation_checkout_stat.id, :manifestation_checkout_stat => @attrs
          assigns(:manifestation_checkout_stat).should eq(@manifestation_checkout_stat)
        end
      end

      describe "with invalid params" do
        it "assigns the requested manifestation_checkout_stat as @manifestation_checkout_stat" do
          put :update, :id => @manifestation_checkout_stat.id, :manifestation_checkout_stat => @invalid_attrs
          response.should render_template("edit")
        end
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in Factory(:librarian)
      end

      describe "with valid params" do
        it "updates the requested manifestation_checkout_stat" do
          put :update, :id => @manifestation_checkout_stat.id, :manifestation_checkout_stat => @attrs
        end

        it "assigns the requested manifestation_checkout_stat as @manifestation_checkout_stat" do
          put :update, :id => @manifestation_checkout_stat.id, :manifestation_checkout_stat => @attrs
          assigns(:manifestation_checkout_stat).should eq(@manifestation_checkout_stat)
          response.should redirect_to(@manifestation_checkout_stat)
        end
      end

      describe "with invalid params" do
        it "assigns the manifestation_checkout_stat as @manifestation_checkout_stat" do
          put :update, :id => @manifestation_checkout_stat, :manifestation_checkout_stat => @invalid_attrs
          assigns(:manifestation_checkout_stat).should_not be_valid
        end

        it "re-renders the 'edit' template" do
          put :update, :id => @manifestation_checkout_stat, :manifestation_checkout_stat => @invalid_attrs
          response.should render_template("edit")
        end
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in Factory(:user)
      end

      describe "with valid params" do
        it "updates the requested manifestation_checkout_stat" do
          put :update, :id => @manifestation_checkout_stat.id, :manifestation_checkout_stat => @attrs
        end

        it "assigns the requested manifestation_checkout_stat as @manifestation_checkout_stat" do
          put :update, :id => @manifestation_checkout_stat.id, :manifestation_checkout_stat => @attrs
          assigns(:manifestation_checkout_stat).should eq(@manifestation_checkout_stat)
          response.should be_forbidden
        end
      end

      describe "with invalid params" do
        it "assigns the requested manifestation_checkout_stat as @manifestation_checkout_stat" do
          put :update, :id => @manifestation_checkout_stat.id, :manifestation_checkout_stat => @invalid_attrs
          response.should be_forbidden
        end
      end
    end

    describe "When not logged in" do
      describe "with valid params" do
        it "updates the requested manifestation_checkout_stat" do
          put :update, :id => @manifestation_checkout_stat.id, :manifestation_checkout_stat => @attrs
        end

        it "should be forbidden" do
          put :update, :id => @manifestation_checkout_stat.id, :manifestation_checkout_stat => @attrs
          response.should redirect_to(new_user_session_url)
        end
      end

      describe "with invalid params" do
        it "assigns the requested manifestation_checkout_stat as @manifestation_checkout_stat" do
          put :update, :id => @manifestation_checkout_stat.id, :manifestation_checkout_stat => @invalid_attrs
          response.should redirect_to(new_user_session_url)
        end
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      @manifestation_checkout_stat = Factory(:manifestation_checkout_stat)
    end

    describe "When logged in as Administrator" do
      before(:each) do
        sign_in Factory(:admin)
      end

      it "destroys the requested manifestation_checkout_stat" do
        delete :destroy, :id => @manifestation_checkout_stat.id
      end

      it "redirects to the manifestation_checkout_stats list" do
        delete :destroy, :id => @manifestation_checkout_stat.id
        response.should redirect_to(manifestation_checkout_stats_url)
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in Factory(:librarian)
      end

      it "destroys the requested manifestation_checkout_stat" do
        delete :destroy, :id => @manifestation_checkout_stat.id
      end

      it "redirects to the manifestation_checkout_stats list" do
        delete :destroy, :id => @manifestation_checkout_stat.id
        response.should redirect_to(manifestation_checkout_stats_url)
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in Factory(:user)
      end

      it "destroys the requested manifestation_checkout_stat" do
        delete :destroy, :id => @manifestation_checkout_stat.id
      end

      it "should be forbidden" do
        delete :destroy, :id => @manifestation_checkout_stat.id
        response.should be_forbidden
      end
    end

    describe "When not logged in" do
      it "destroys the requested manifestation_checkout_stat" do
        delete :destroy, :id => @manifestation_checkout_stat.id
      end

      it "should be forbidden" do
        delete :destroy, :id => @manifestation_checkout_stat.id
        response.should redirect_to(new_user_session_url)
      end
    end
  end
end
