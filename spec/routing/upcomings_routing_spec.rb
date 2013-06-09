require "spec_helper"

describe UpcomingsController do
  describe "routing" do

    it "routes to #index" do
      get("/upcomings").should route_to("upcomings#index")
    end

    it "routes to #new" do
      get("/upcomings/new").should route_to("upcomings#new")
    end

    it "routes to #show" do
      get("/upcomings/1").should route_to("upcomings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/upcomings/1/edit").should route_to("upcomings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/upcomings").should route_to("upcomings#create")
    end

    it "routes to #update" do
      put("/upcomings/1").should route_to("upcomings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/upcomings/1").should route_to("upcomings#destroy", :id => "1")
    end

  end
end
