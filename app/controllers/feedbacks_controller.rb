class FeedbacksController < ApplicationController
  def index
    @filter = selected_filter
    @feedbacks = filtered_feedbacks
  end

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)

    if @feedback.save
      redirect_to @feedback, notice: "Feedback was submitted."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @feedback = Feedback.find(params[:id])
  end

  def update
    @feedback = Feedback.find(params[:id])
    filter = selected_filter

    if @feedback.update(category_params)
      redirect_to feedbacks_path(filter: filter), notice: "Category updated."
    else
      redirect_to feedbacks_path(filter: filter), alert: @feedback.errors.full_messages.to_sentence
    end
  end

  private

  def feedback_params
    params.expect(feedback: [:title, :description])
  end

  def category_params
    params.expect(feedback: [:category])
  end

  def selected_filter
    filter = params[:filter].presence || Feedback::FILTER_ALL
    Feedback::FILTERS.include?(filter) ? filter : Feedback::FILTER_ALL
  end

  def filtered_feedbacks
    scope = Feedback.inbox_order
    filter = selected_filter
    filter == Feedback::FILTER_ALL ? scope : scope.in_category(filter)
  end
end
