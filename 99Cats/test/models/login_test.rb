# == Schema Information
#
# Table name: logins
#
#  id            :integer          not null, primary key
#  session_token :string           not null
#  user_id       :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  ip_address    :string
#  machine_type  :string
#  latitude      :integer
#  longitude     :integer
#

require 'test_helper'

class LoginTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
