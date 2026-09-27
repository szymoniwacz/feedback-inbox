# Synthetic demo feedback — safe to load in development. Idempotent via find_or_create_by! on title.

[
  {
    title: "Checkout button unresponsive on mobile",
    description: "Tapping Submit on the cart page does nothing in Safari on iOS 17. Desktop Chrome works.",
    category: "bug"
  },
  {
    title: "Export inbox to CSV",
    description: "Would help share filtered feedback with stakeholders without screenshots.",
    category: "feature request"
  },
  {
    title: "Clarify category labels",
    description: "Consider tooltips explaining when to pick bug vs feature request vs other.",
    category: "other"
  },
  {
    title: "Filter resets after invalid category",
    description: "After a bad category update, the list filter jumps back to All unexpectedly.",
    category: "bug"
  }
].each do |attrs|
  Feedback.find_or_create_by!(title: attrs[:title]) do |feedback|
    feedback.description = attrs[:description]
    feedback.category = attrs[:category]
  end
end
