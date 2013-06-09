require 'spec_helper'

describe "upcomings/edit" do
  before(:each) do
    @upcoming = assign(:upcoming, stub_model(Upcoming,
      :who => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit upcoming form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", upcoming_path(@upcoming), "post" do
      assert_select "input#upcoming_who[name=?]", "upcoming[who]"
      assert_select "input#upcoming_description[name=?]", "upcoming[description]"
    end
  end
end
