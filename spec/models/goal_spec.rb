# == Schema Information
#
# Table name: goals
#
#  id           :integer          not null, primary key
#  content      :text             not null
#  user_id      :integer          not null
#  private      :boolean          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  completed_on :date
#

require 'rails_helper'

RSpec.describe Goal, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
