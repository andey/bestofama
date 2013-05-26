require 'spec_helper'

describe "upcomings/index" do
  before(:each) do
    assign(:upcomings, [
      stub_model(Upcoming,
        :who => "Who",
        :description => "Description"
      ),
      stub_model(Upcoming,
        :who => "Who",
        :description => "Description"
      )
    ])
  end

  it "renders a list of upcomings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Who".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
