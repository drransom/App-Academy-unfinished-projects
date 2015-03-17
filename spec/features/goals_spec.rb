require 'spec_helper'
require 'rails_helper'

describe Goal do
  describe "validations" do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:user) }
    # it { should ensure_inclusion_of(:private).in_array([true, false]) }
  end

  describe "associations" do
    it { should belong_to(:user) }
  end
end

feature "creating goals" do
  before(:each) do
    @bob = create_user
    sign_in(@bob)
    visit user_url(@bob)
  end

  it "has a link to the new goal page" do
    expect(page).to have_link("Create New Goal", href: new_user_goal_url(@bob))
  end

  it "has a new goal page" do
    click_link 'Create New Goal'

    expect(page).to have_field('Goal')
    expect(page).to have_field('Privacy')
  end

  it "creates a new goal" do
    click_link 'Create New Goal'
    fill_in('Goal', with: "My test goal")
    choose('Private goal')
    click_on('Create New Goal')
    expect(page).to have_content("My test goal")
  end

  it "doesn't have create link for other users" do
    log_out
    visit user_url(@bob)
    expect(page).to_not have_link("Create New Goal")
    bobby = create_user('bobby')
    sign_in(bobby)
    visit user_url(@bob)
    expect(page).to_not have_link("Create New Goal")
  end
end

feature "viewing goals" do
  before(:each) do
    @bob = create_user
    @private_goal = Goal.create(user_id: @bob.id,
                               private: true,
                               content: "You can't see this")
    @public_goal = Goal.create(user_id: @bob.id,
                                private: false,
                                content: "You can see this")
  end

  feature "from the user page" do
    it "users can't see other users' private goals" do
      bob2 = create_user("bob2")
      sign_in(bob2)
      visit user_url(@bob)
      expect(page).to have_content(@public_goal.content)
      expect(page).to_not have_content(@private_goal.content)
    end

    it "users can see their own private goals" do
      sign_in(@bob)
      visit user_url(@bob)
      expect(page).to have_content(@public_goal.content)
      expect(page).to have_content(@private_goal.content)
    end

    it "has link to goal show page" do
      sign_in(@bob)
      visit user_url(@bob)
      expect(page).to have_link(@private_goal.content)
      expect(page).to have_link(@public_goal.content)
    end
  end

  feature "from the goal show page" do
    it "shows goal details" do
      sign_in(@bob)
      visit goal_url(@private_goal)
      expect(page).to have_content(@private_goal.content)
      expect(page).to have_content("in progress")
      expect(page).to_not have_content("completed on")
    end

    it "shows completion details of completed goals" do
      sign_in(@bob)
      @private_goal.update(completed_on: Date.yesterday)
      visit goal_url(@private_goal)
      expect(page).to have_content("completed on")
    end
  end

  it "users cannot see others users private goals" do
    bobby = create_user("bobby")
    sign_in(bobby)
    visit goal_url(@private_goal)
    expect(page).to have_content("bobby's Page")
  end

end

feature "destroying goals" do
  before(:each) do
    @bob = create_user
    @private_goal = Goal.create(user_id: @bob.id,
                               private: true,
                               content: "You can't see this")
    @public_goal = Goal.create(user_id: @bob.id,
                                private: false,
                                content: "You can see this")
  end

  it "users can delete their own goals" do
    sign_in(@bob)
    visit user_url(@bob)
    click_button("delete_goal_#{@private_goal.id}")
    expect(page).to have_content(@public_goal.content)
    expect(page).to_not have_content(@private_goal.content)
  end

  it "users cannot delete other users' goals" do
    bobby = create_user("bobby")
    sign_in(bobby)
    visit user_url(@bob)
    expect(page).to_not have_button("Delete goal")
  end
end

feature "editing goals" do
  before(:each) do
    @bob = create_user
    @goal = Goal.create(user_id: @bob.id,
                        private: true,
                        content: "You can't see this")
  end

  it "users can edit their own goals" do
    sign_in(@bob)
    visit user_url(@bob)
    click_link('Edit goal', href: edit_goal_url(@goal))
    expect(page).to have_content("Edit Goal")
  end

  it "users cannot edit other users' goals" do
    bobby = create_user("bobby")
    sign_in(bobby)
    visit user_url(@bob)
    expect(page).to_not have_link(edit_goal_url(@goal))
  end

  it "goals can be edited" do
    sign_in(@bob)
    visit edit_goal_url(@goal)
    fill_in('Goal', with: 'updated content')
    choose('Public goal')
    click_on('Update Goal')
    @goal.reload
    expect(@goal.private).to be false
    expect(page).to have_content('updated content')
    expect(page).to_not have_content("You can't see this")
  end

  it "renders errors" do
    sign_in(@bob)
    visit edit_goal_url(@goal)
    fill_in('Goal', with: '')
    click_on('Update Goal')
    expect(page).to have_content("Content can't be blank")
  end

  it "includes previously filled-in content" do
    sign_in(@bob)
    visit edit_goal_url(@goal)
    expect(find_field('Goal').value).to have_content(@goal.content)
    expect(find_field('Private goal')).to be_checked
    expect(find_field('Public goal')).to_not be_checked
  end
end

feature "completing goals" do
  before(:each) do
    @bob = create_user
    @goal = Goal.create(user_id: @bob.id,
                        private: false,
                        content: "You can see this")
    sign_in(@bob)
    visit user_url(@bob)
  end

  it "defaults to showing goals as not completed" do
    expect(page).to have_button("Mark as completed")
    expect(page).to_not have_content("completed on")
  end

  it "clicking marks goals as completed" do
    click_on("Mark as completed")
    expect(page).to have_content("completed on")
    expect(page).to_not have_button("Mark as completed")
  end

  it "a different user sees uncompleted goals as in progress" do
    log_out
    bobby = create_user("bobby")
    sign_in(bobby)
    visit user_url(@bob)
    expect(page).to have_content("in progress")
    expect(page).to_not have_button("Mark as completed")
  end

  it "shows other users completion dates" do
    click_on("Mark as completed")
    log_out
    bobby = create_user("bobby")
    sign_in(bobby)
    visit user_url(@bob)
    expect(page).to have_content("completed on")
  end
end
