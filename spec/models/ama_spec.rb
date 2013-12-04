# == Schema Information
#
# Table name: amas
#
#  id         :integer          not null, primary key
#  key        :string(255)      not null
#  date       :datetime         not null
#  title      :string(255)      not null
#  content    :text
#  karma      :integer          default(0)
#  user_id    :integer          not null
#  permalink  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  comments   :integer          default(0)
#  responses  :integer          default(0)
#

require 'spec_helper'
require 'api/reddit.com'

describe Ama do

  it 'create_by_json from /r/IAmA.json' do

    # Fetch /r/IAmA.json
    reddit = Reddit.new
    json = reddit.getIAMAs()
    @amas = json["data"]["children"]

    # Find a reddit AMA from API
    data = @amas[0]["data"]

    # Init AMA, and create
    ama = Ama.new
    ama = ama.create_by_json(data)

    # Check if AMA saved
    ama.should_not be(false)

  end

  describe 'comments/z1c9z.json' do

    before(:all) do
      # Create basic AMA with PresidentObama as the OP
      user = FactoryGirl.create(:user, username: 'PresidentObama')
      @ama = FactoryGirl.create(:ama, user: user)

      # Now Update AMA
      @ama.key = 'z1c9z'
      @ama.fetch()
    end

    it 'karma score is updated' do
      @ama.karma.should be(14752)
    end

    it 'OP comment is saved' do
      Comment.find_by_key('c60n05h').should_not be(nil)
    end

    it "regular comment isn't relevant" do
      Comment.find_by_key('c60n1lg').relevant.should be(false)
    end

    it 'regular comment responded to is relevant' do
      Comment.find_by_key('c60mm41').relevant.should be(true)
    end

    after(:all) do
      User.delete_all
      Ama.delete_all
      Archive.delete_all
    end

  end

end
