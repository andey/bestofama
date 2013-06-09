require 'spec_helper'

describe "upcomings/new" do
  before(:each) do
    assign(:upcoming, stub_model(Upcoming,
      :who => "MyString",
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new upcoming form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", upcomings_path, "post" do
      assert_select "input#upcoming_who[name=?]", "upcoming[who]"
      assert_select "input#upcoming_description[name=?]", "upcoming[description]"
    end
  end
end
