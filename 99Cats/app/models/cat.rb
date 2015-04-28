# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  color       :string           not null
#  name        :string           not null
#  sex         :string           not null
#  description :text
#  birth_date  :date
#  user_id     :integer
#

class Cat < ActiveRecord::Base
  COLORS = ["orange", "brown", "red", "white", "green",
            "black", "gray"]

  has_many :cat_rental_requests, dependent: :destroy
  belongs_to :user

  validates :birth_date, :name, :user_id, presence: true
  validates :color, inclusion: COLORS
  validates :sex, inclusion: ["F", "M"]

  def age
    dob = birth_date
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month ||
      (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def colors
    COLORS
  end
end
