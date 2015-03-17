require 'spec_helper'
require 'rails_helper'

describe User do
  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
  end

  describe "associations" do
    it { should have_many(:goals) }
  end
end
