# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
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
  has_many :comments

  def self.children_of(comment_id, comment_array)
    #returns all comments in comment_array with parent_id == comment_id.
    comment_array.select { |comment| comment.parent_comment_id == comment_id }
  end

  def comments_by_parent_id
    comment_hash = Hash.new { | hash, key | hash[key] = Array.new }
    self.comments.order(created_at: :desc).each do |comment|
      comment_hash[comment.parent_comment_id] << comment
    end
    comment_hash
  end

  def at_least_one_sub
    if self.subs.empty?
      errors[:base] << "Post must have at least one associated sub"
    end
  end
end
