require 'rails_helper'

RSpec.describe Note, type: :model do
  it "generates associated data from a factory" do
    note = FactoryBot.create(:note)
    puts "This note's project is #{note.project.inspect}"
    puts "This note's user is #{note.user.inspect}"
  end
  before do
      @user = User.create(
          first_name: "Joe",
          last_name: "Tester",
          email: "test3@example.com",
          password: "password123"
        )

      @project = @user.projects.create(
        name: "Test Project",
      )
  end

  # projectとuserがあり、メッセージが有効
  it "is valid with a user, project, and message" do
    note = Note.new(
      message: "ohayou",
      user: @user,
      project: @project,
    )
    expect(note).to be_valid
  end
  # projectとuserがあり、メッセージがなし
  it "is valid without message" do
    note = Note.new(
      message: nil,
      user: @user,
      project: @project,
    )
    note.valid?
    expect(note.errors[:message]).to include("can't be blank")
  end

  describe "search message for a term" do
    before do
      @note1 = @project.notes.create(
        message: "This is the first note.",
        user: @user,
      )

      @note2 = @project.notes.create(
        message: "This is the second note.",
        user: @user,
      )

      @note3 = @project.notes.create(
        message: "First, preheat the oven.",
        user: @user,
      )
    end
    context 'when a match is found' do
      it "returns notes that match the search term" do
        expect(Note.search("first")).to include(@note1, @note3)
      end
    end

    context "when no match is found" do
      it "returns an empty collection" do
        expect(Note.search("message")).to be_empty
      end
    end
  end
end
