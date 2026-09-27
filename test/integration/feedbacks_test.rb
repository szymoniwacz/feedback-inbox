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

  test "valid category change persists after reload" do
    feedback = Feedback.create!(title: "Recategorize me", description: "Needs triage.", category: "other")

    patch feedback_path(feedback), params: { feedback: { category: "bug" } }
    assert_redirected_to feedbacks_path(filter: Feedback::FILTER_ALL)

    feedback.reload
    assert_equal "bug", feedback.category

    get feedbacks_path
    assert_response :success
    assert_select "select#feedback_#{feedback.id}_category option[selected][value=?]", "bug"
  end

  test "invalid category is rejected and stored data is unchanged" do
    feedback = Feedback.create!(title: "Stable item", description: "Should not change.", category: "other")

    patch feedback_path(feedback), params: { feedback: { category: "invalid" } }
    assert_redirected_to feedbacks_path(filter: Feedback::FILTER_ALL)
    follow_redirect!

    assert_response :success
    assert_match "Category is not included in the list", response.body
    assert_equal "other", feedback.reload.category

    get new_feedback_path
    assert_response :success
    assert_select "form[action=?]", feedbacks_path
  end

  test "filter shows only items in the selected category" do
    bug = Feedback.create!(title: "Bug item", description: "Broken.", category: "bug")
    feature = Feedback.create!(title: "Feature item", description: "Idea.", category: "feature request")
    Feedback.create!(title: "Other item", description: "Fine.", category: "other")

    {
      "bug" => [bug.title],
      "feature request" => [feature.title],
      "other" => ["Other item"]
    }.each do |filter, expected_titles|
      get feedbacks_path(filter: filter)

      assert_response :success
      assert_equal expected_titles, css_select("h2").map(&:text)
    end
  end

  test "filter all restores full inbox" do
    first = Feedback.create!(title: "First", description: "One.", category: "bug")
    second = Feedback.create!(title: "Second", description: "Two.", category: "other")

    get feedbacks_path(filter: "all")

    assert_response :success
    titles = css_select("h2").map(&:text)
    assert_equal [second, first].map(&:title), titles
  end

  test "empty category filter explains no matching items" do
    Feedback.create!(title: "Only other", description: "Not a bug.", category: "other")

    get feedbacks_path(filter: "bug")

    assert_response :success
    assert_select "h2", count: 0
    assert_match "No feedback in the", response.body
    assert_match "bug", response.body
  end

  test "invalid category update preserves active filter" do
    feedback = Feedback.create!(title: "Stable", description: "Stays other.", category: "other")
    Feedback.create!(title: "Bug only", description: "For filter.", category: "bug")

    patch feedback_path(feedback, filter: "bug"), params: { feedback: { category: "invalid" } }
    follow_redirect!

    assert_response :success
    assert_match "Category is not included in the list", response.body
    assert_select "h2", text: "Bug only"
    assert_select "input#filter_bug[checked]"
  end

  test "category filter controls are labelled" do
    get feedbacks_path

    assert_response :success
    assert_select "fieldset legend", text: "Filter by category"
    assert_select "label[for=?]", "filter_all"
    assert_select "label[for=?]", "filter_bug"
  end

  test "inbox category controls have unique ids and labels per item" do
    first = Feedback.create!(title: "First", description: "One.", category: "other")
    second = Feedback.create!(title: "Second", description: "Two.", category: "bug")

    get feedbacks_path

    assert_response :success
    assert_select "label[for=?]", "feedback_#{first.id}_category"
    assert_select "label[for=?]", "feedback_#{second.id}_category"
    assert_select "select#feedback_#{first.id}_category"
    assert_select "select#feedback_#{second.id}_category"
  end
end
