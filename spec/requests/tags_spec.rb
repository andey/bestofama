require 'spec_helper'

describe "Tags" do
  describe "GET /tag/:tag" do
    it "shows tag page" do
      entity = FactoryGirl.create(:entity, :tag_list => "test")
      get tag_path('test')
      response.body.should include(entity.name)
    end

    it "missing tag redirects to tags_path()" do
      get tag_path('missing')
      response.body.should redirect_to tags_path()
    end
  end

  describe "GET /tags" do
    it "show index" do

      # poor test
      # needs improvements

      get tags_path
      response.code.should == 200.to_s
    end
  end
end
