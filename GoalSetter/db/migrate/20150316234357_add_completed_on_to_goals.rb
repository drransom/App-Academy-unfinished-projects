class AddCompletedOnToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :completed_on, :date
  end
end
