# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  sub_id     :integer          not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :author, presence: true
  validate :at_least_one_sub

  belongs_to :author, class_name: :User
  has_many :post_subs, dependent: :destroy

  has_many :subs, through: :post_subs, source: :sub

  def at_least_one_sub
    if self.subs.empty?
      errors[:base] << "Post must have at least one associated sub"
    end
  end
end
