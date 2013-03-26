require 'spec_helper'

describe "Entities" do
  describe "GET /entities" do
    it "displays entities" do
      FactoryGirl.create(:entity, name: "Jesus", slug: "jesus")
      get entities_path
      response.body.should include("Jesus")
      response.body.should include(entity_path("jesus"))
    end
  end

  describe "GET /entity/:slug" do
    it "displays an entity" do
      entity = FactoryGirl.create(:entity)
      get entity_path(entity.slug)
      response.body.should include(entity.name)
    end

    it "should not have form" do
      entity = FactoryGirl.create(:entity)
      get entity_path(entity.slug)
      response.body.should_not include('edit-box')
    end

    #it "should have form when logged in" do
    #
    #  activate_authlogic
    #
    #  user = FactoryGirl.create(:user)
    #  UserSession.create(user)
    #
    #  entity = FactoryGirl.create(:entity)
    #  get entity_path(entity.slug)
    #
    #  response.body.should include('edit-box')
    #end
  end
end
