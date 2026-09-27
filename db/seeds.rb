# Synthetic demo feedback covering each allowed category (FR-008).
# Idempotent: safe to run multiple times in development.

samples = [
  {
    title: "Submit button misaligned on mobile",
    description: "On a narrow viewport the primary submit control sits outside the form card.",
    category: "bug"
  },
  {
    title: "Export inbox to CSV",
    description: "Would help share filtered feedback with stakeholders during reviews.",
    category: "feature request"
  },
  {
    title: "Clarify default category on new feedback",
    description: "A short hint that uncategorized items appear as Other would reduce confusion.",
    category: "other"
  }
]

samples.each do |attrs|
  feedback = Feedback.find_or_initialize_by(title: attrs[:title])
  feedback.description = attrs[:description]
  feedback.category = attrs[:category]
  feedback.save!
end
