# == Schema Information
#
# Table name: archives
#
#  id         :integer          not null, primary key
#  ama_id     :integer
#  created_at :datetime
#  updated_at :datetime
#  json       :hstore
#

require 'spec_helper'

describe Archive do
  pending "add some examples to (or delete) #{__FILE__}"
end
