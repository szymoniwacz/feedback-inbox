class Feedback < ApplicationRecord
  CATEGORIES = %w[bug feature\ request other].freeze

  before_validation :assign_default_category

  validates :title, presence: true
  validates :description, presence: true
  validates :category, inclusion: { in: CATEGORIES }

  private

  def assign_default_category
    self.category = "other" if category.blank?
  end
end
