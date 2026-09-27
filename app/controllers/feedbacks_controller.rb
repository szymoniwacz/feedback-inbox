class FeedbacksController < ApplicationController
  def index
    @feedbacks = Feedback.inbox_order
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

    if @feedback.update(category_params)
      redirect_to feedbacks_path, notice: "Category updated."
    else
      redirect_to feedbacks_path, alert: @feedback.errors.full_messages.to_sentence
    end
  end

  private

  def feedback_params
    params.expect(feedback: [:title, :description])
  end

  def category_params
    params.expect(feedback: [:category])
  end
end
