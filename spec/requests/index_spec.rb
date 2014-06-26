require 'spec_helper'

describe IndexController do

  before(:all) do
    10.times do
      FactoryGirl.create(:ama)
      FactoryGirl.create(:upcoming)
    end
  end

  it 'returns status code 200' do
    get root_path
    expect(response.status).to eq(200)
  end

  context 'upcomings' do
    it 'in DESC order' do
      get root_path
      expect(response.body).to include 'John Doe 5'
      expect(response.body).to_not include 'John Doe 6'
    end
  end

  #context 'amas' do
  #  it 'in correct order' do
  #    get root_path
  #    expect(response.body).to include 'AMA Title #5'
  #    expect(response.body).to_not include 'AMA Title #6'
  #  end
  #end

  after(:all) do
    Ama.delete_all
    User.delete_all
    Upcoming.delete_all
  end

end
