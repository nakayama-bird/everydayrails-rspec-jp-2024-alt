require 'rails_helper'

RSpec.describe Project, type: :model do
  before do
    @user = User.create(
        first_name: "Joe",
        last_name: "Tester",
        email: "test7@example.com",
        password: "password123"
      )

    @user.projects.create(
      name: "Test Project"
    )
  end

  it 'does not allow duplicate project names per user' do
    new_project = @user.projects.build(
      name: "Test Project"
    )
    new_project.valid?
    expect(new_project.errors[:name]).to include("has already been taken")
  end

  it 'allows two users to share a project name' do
    other_user = User.create(
        first_name: "Jone",
        last_name: "Tester",
        email: "tester@example.com",
        password: "password123"
      )

    other_project = other_user.projects.create(
      name: "Test Project"
    )

    expect(other_project).to be_valid
  end
end
