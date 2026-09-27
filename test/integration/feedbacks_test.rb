require "test_helper"

class FeedbacksTest < ActionDispatch::IntegrationTest
  test "valid submission creates feedback and redirects to confirmation" do
    assert_difference -> { Feedback.count }, 1 do
      post feedbacks_path, params: {
        feedback: { title: "Slow export", description: "Export takes too long on large files." }
      }
    end

    feedback = Feedback.order(:id).last
    assert_redirected_to feedback_path(feedback)
    follow_redirect!
    assert_response :success
    assert_match "Slow export", response.body
  end

  test "blank fields re-render form with errors and preserved input" do
    assert_no_difference -> { Feedback.count } do
      post feedbacks_path, params: {
        feedback: { title: "", description: "Only description" }
      }
    end

    assert_response :unprocessable_entity
    assert_match "Title can&#39;t be blank", response.body
    assert_match "Only description", response.body
  end

  test "submission form has labelled controls" do
    get new_feedback_path

    assert_response :success
    assert_select "label[for=?]", "feedback_title"
    assert_select "label[for=?]", "feedback_description"
  end

  test "inbox lists feedback newest first with tie-break by id" do
    older = Feedback.create!(
      title: "Older item",
      description: "First created.",
      category: "other",
      created_at: 2.hours.ago
    )
    newer = Feedback.create!(
      title: "Newer item",
      description: "Second created.",
      category: "bug",
      created_at: 1.hour.ago
    )
    tie_a = Feedback.create!(
      title: "Tie A",
      description: "Same timestamp as tie B.",
      category: "other",
      created_at: Time.zone.parse("2020-01-01 12:00:00")
    )
    tie_b = Feedback.create!(
      title: "Tie B",
      description: "Same timestamp as tie A.",
      category: "other",
      created_at: Time.zone.parse("2020-01-01 12:00:00")
    )

    get feedbacks_path

    assert_response :success
    titles = css_select("h2").map(&:text)
    assert_equal [newer, older, tie_b, tie_a].map(&:title), titles
    assert_select "dt", text: "Category", count: 4
    assert_select "dt", text: "Submitted", count: 4
  end

  test "home links to inbox" do
    get root_path

    assert_response :success
    assert_select "a[href=?]", feedbacks_path, text: "Browse inbox"
  end
end
