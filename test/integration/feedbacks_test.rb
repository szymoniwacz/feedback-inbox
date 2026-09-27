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
end
