# == Schema Information
#
# Table name: upcomings
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  date        :datetime
#  description :string(255)
#  url         :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Upcoming do
  pending "add some examples to (or delete) #{__FILE__}"
end
