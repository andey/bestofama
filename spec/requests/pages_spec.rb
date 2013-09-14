require 'spec_helper'

describe "Pages" do

  it "show index page" do
    get root_path
    response.code.to_i.should eq(200)
  end

end
