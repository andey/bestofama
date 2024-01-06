class OpsUser < ActiveRecord::Base
  belongs_to :op
  belongs_to :user
end
