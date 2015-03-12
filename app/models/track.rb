# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  album_id   :integer
#  bonus      :boolean          default("false"), not null
#  name       :string           not null
#  lyrics     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ActiveRecord::Base
  validates :bonus, :name, presence: true

  belongs_to :album
  has_one :band, through: :album, source: :band
end
