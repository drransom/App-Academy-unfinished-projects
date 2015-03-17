require 'spec_helper'
require 'rails_helper'

# describe Comment do
#   describe "associations" do
#     it { should validate_presence_of(:body) }
#     it { should validate_presence_of(:author) }
#   end
# end

feature "comments on users" do
  before(:each) do
    @bob = create_user("bob")
    @bobby = create_user("bobby")
    sign_in(@bobby)
    visit user_url(@bob)
  end

  it "should have comment box" do
    expect(page).to have_content('Add a comment')
    expect(page).to have_button('Submit comment')
  end

  it "should accept comments" do
    fill_in('Add a comment', with: 'I have a comment')
    click_on('Submit comment')
    expect(page).to have_content('I have a comment')
  end

  it "should not allow blank comments" do
    fill_in('Add a comment', with: '')
    click_on('Submit comment')
    expect(page).to have_content("Body can't be blank")
  end

  it "shows the author's name next to each comment" do
    fill_in('Add a comment', with: 'I have a comment')
    click_on('Submit comment')
    expect(page).to have_content("added by bobby")
  end

  it "users should be able to view other users' comments" do
    fill_in('Add a comment', with: 'I have a comment')
    click_on('Submit comment')
    log_out
    sign_in(@bob)
    visit user_url(@bob)
    expect(page).to have_content('I have a comment')
  end
end

feature "comments on goals" do
  before(:each) do
    @bob = create_user("bob")
    @goal = @bob.goals.create(title: 'do the thing', private: false)
    @bobby = create_user("bobby")
    sign_in(@bobby)
    visit goal_url(@goal)
  end

  it "should have comment box" do
    expect(page).to have_content('Add a comment')
    expect(page).to have_button('Submit comment')
  end

  it "should accept comments" do
    fill_in('Add a comment', with: 'I have a comment')
    click_on('Submit comment')
    expect(page).to have_content('I have a comment')
  end

  it "should not allow blank comments" do
    fill_in('Add a comment', with: '')
    click_on('Submit comment')
    expect(page).to have_content("Body can't be blank")
  end

  it "shows the author's name next to each comment" do
    fill_in('Add a comment', with: 'I have a comment')
    click_on('Submit comment')
    expect(page).to have_content("added by bobby")
  end

  it "users should be able to view other users' comments" do
    fill_in('Add a comment', with: 'I have a comment')
    click_on('Submit comment')
    log_out
    sign_in(@bob)
    visit goal_url(@goal)
    expect(page).to have_content('I have a comment')
  end
end
