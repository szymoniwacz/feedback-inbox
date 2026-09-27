require "test_helper"

class FeedbackTest < ActiveSupport::TestCase
  test "requires title and description" do
    feedback = Feedback.new

    assert_not feedback.valid?
    assert_includes feedback.errors[:title], "can't be blank"
    assert_includes feedback.errors[:description], "can't be blank"
  end

  test "defaults category to other" do
    feedback = Feedback.create!(title: "Example", description: "Details")

    assert_equal "other", feedback.category
  end

  test "accepts allowed categories" do
    feedback = Feedback.new(title: "T", description: "D", category: "bug")

    assert feedback.valid?
  end
end
