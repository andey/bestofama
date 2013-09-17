require 'spec_helper'

describe "Index" do
  fixtures :upcoming, :ama

  it 'returns status code 200' do
    get root_path
    expect(response.status).to eq(200)
  end

  context 'upcomings' do
    it 'not include past' do
      get root_path
      expect(response.body).to_not include 'John Doe (Past)'
    end

    it 'include future' do
      get root_path
      expect(response.body).to include 'John Doe (Future)'
    end

    it 'in DESC order' do
      get root_path
      expect(response.body).to include 'John Doe (Future) 5'
      expect(response.body).to_not include 'John Doe (Future) 6'
    end
  end

  context 'amas' do
    it 'in correct order' do
      get root_path
      expect(response.body).to include 'AMA Title 4'
      expect(response.body).to_not include 'AMA Title 5'
    end
  end

end
