# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ActiveRecord::Base
  belongs_to :cat

  def sibling_requests
    cat.cat_rental_requests.where.not(id: self.id)
  end

  before_validation(on: :create) do
    self.status ||= 'PENDING'
  end

  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: ['PENDING', 'APPROVED', 'DENIED']
  validate :no_overlapping_approved_requests

  def approve!
    self.transaction do
      self.status = "APPROVED"
      self.save
      sibling_requests.each do |sibling|
        if sibling.status == "PENDING" && overlapping_request?(sibling)
          sibling.status = "DENIED"
          sibling.save
        end
        all.update()
      end
    end
  end

  # def overlapping_sibling_requests
  #   TODO
  #   sibling_requests.where( FIGURE OUT CONDITION )
  # end

  private
  def overlapping_request?(other_request)
    (cat_id == other_request.cat_id) && (start_date <= other_request.end_date) &&
      (other_request.start_date <= end_date)
  end

  def overlapping_approved_requests(other_request)
    overlapping_request?(other_request) && other_request.status == "APPROVED"
  end

  def no_overlapping_approved_requests
    sibling_requests.any? do |other_request|
      overlapping_approved_requests(other_request) &&
        !other_request.equal?(self)
    end
  end

end
