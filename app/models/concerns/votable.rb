module Votable
  extend ActiveSupport::Concern

  def upvote!
    Vote.create(votable_id: self.id, votable_type: self.class.name, voter_id: current_user.id, value: 1)
  end

  def downvote!
    Vote.create(votable_id: self.id, votable_type: self.class.name, voter_id: current_user.id, value: -1)
  end
end
