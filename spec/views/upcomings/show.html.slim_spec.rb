require 'spec_helper'

describe "upcomings/show" do
  before(:each) do
    @upcoming = assign(:upcoming, stub_model(Upcoming,
      :who => "Who",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Who/)
    rendered.should match(/Description/)
  end
end
