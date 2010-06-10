require 'spec_helper'

describe ScheduledPhotosController do

  def mock_scheduled_photo(stubs={})
    @mock_scheduled_photo ||= mock_model(ScheduledPhoto, stubs)
  end

  describe "GET index" do
    it "assigns all scheduled_photos as @scheduled_photos" do
      ScheduledPhoto.stub(:find).with(:all).and_return([mock_scheduled_photo])
      get :index
      assigns[:scheduled_photos].should == [mock_scheduled_photo]
    end
  end

  describe "GET show" do
    it "assigns the requested scheduled_photo as @scheduled_photo" do
      ScheduledPhoto.stub(:find).with("37").and_return(mock_scheduled_photo)
      get :show, :id => "37"
      assigns[:scheduled_photo].should equal(mock_scheduled_photo)
    end
  end

  describe "GET new" do
    it "assigns a new scheduled_photo as @scheduled_photo" do
      ScheduledPhoto.stub(:new).and_return(mock_scheduled_photo)
      get :new
      assigns[:scheduled_photo].should equal(mock_scheduled_photo)
    end
  end

  describe "GET edit" do
    it "assigns the requested scheduled_photo as @scheduled_photo" do
      ScheduledPhoto.stub(:find).with("37").and_return(mock_scheduled_photo)
      get :edit, :id => "37"
      assigns[:scheduled_photo].should equal(mock_scheduled_photo)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created scheduled_photo as @scheduled_photo" do
        ScheduledPhoto.stub(:new).with({'these' => 'params'}).and_return(mock_scheduled_photo(:save => true))
        post :create, :scheduled_photo => {:these => 'params'}
        assigns[:scheduled_photo].should equal(mock_scheduled_photo)
      end

      it "redirects to the created scheduled_photo" do
        ScheduledPhoto.stub(:new).and_return(mock_scheduled_photo(:save => true))
        post :create, :scheduled_photo => {}
        response.should redirect_to(scheduled_photo_url(mock_scheduled_photo))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved scheduled_photo as @scheduled_photo" do
        ScheduledPhoto.stub(:new).with({'these' => 'params'}).and_return(mock_scheduled_photo(:save => false))
        post :create, :scheduled_photo => {:these => 'params'}
        assigns[:scheduled_photo].should equal(mock_scheduled_photo)
      end

      it "re-renders the 'new' template" do
        ScheduledPhoto.stub(:new).and_return(mock_scheduled_photo(:save => false))
        post :create, :scheduled_photo => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested scheduled_photo" do
        ScheduledPhoto.should_receive(:find).with("37").and_return(mock_scheduled_photo)
        mock_scheduled_photo.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :scheduled_photo => {:these => 'params'}
      end

      it "assigns the requested scheduled_photo as @scheduled_photo" do
        ScheduledPhoto.stub(:find).and_return(mock_scheduled_photo(:update_attributes => true))
        put :update, :id => "1"
        assigns[:scheduled_photo].should equal(mock_scheduled_photo)
      end

      it "redirects to the scheduled_photo" do
        ScheduledPhoto.stub(:find).and_return(mock_scheduled_photo(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(scheduled_photo_url(mock_scheduled_photo))
      end
    end

    describe "with invalid params" do
      it "updates the requested scheduled_photo" do
        ScheduledPhoto.should_receive(:find).with("37").and_return(mock_scheduled_photo)
        mock_scheduled_photo.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :scheduled_photo => {:these => 'params'}
      end

      it "assigns the scheduled_photo as @scheduled_photo" do
        ScheduledPhoto.stub(:find).and_return(mock_scheduled_photo(:update_attributes => false))
        put :update, :id => "1"
        assigns[:scheduled_photo].should equal(mock_scheduled_photo)
      end

      it "re-renders the 'edit' template" do
        ScheduledPhoto.stub(:find).and_return(mock_scheduled_photo(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested scheduled_photo" do
      ScheduledPhoto.should_receive(:find).with("37").and_return(mock_scheduled_photo)
      mock_scheduled_photo.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the scheduled_photos list" do
      ScheduledPhoto.stub(:find).and_return(mock_scheduled_photo(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(scheduled_photos_url)
    end
  end

end
