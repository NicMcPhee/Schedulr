require 'spec_helper'

describe ScheduledPhotosController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/scheduled_photos" }.should route_to(:controller => "scheduled_photos", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/scheduled_photos/new" }.should route_to(:controller => "scheduled_photos", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/scheduled_photos/1" }.should route_to(:controller => "scheduled_photos", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/scheduled_photos/1/edit" }.should route_to(:controller => "scheduled_photos", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/scheduled_photos" }.should route_to(:controller => "scheduled_photos", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/scheduled_photos/1" }.should route_to(:controller => "scheduled_photos", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/scheduled_photos/1" }.should route_to(:controller => "scheduled_photos", :action => "destroy", :id => "1") 
    end
  end
end
