require "test_helper"
require "open3"

class PersistenceRestartTest < ActionDispatch::IntegrationTest
  parallelize(workers: 1)
  self.use_transactional_tests = false

  setup { Feedback.delete_all }
  teardown { Feedback.delete_all }

  test "created and recategorized feedback survives a new Rails process" do
    feedback = Feedback.create!(
      title: "Survives restart",
      description: "Must remain after a new process loads the database.",
      category: "other"
    )
    feedback.update!(category: "feature request")

    db_path = ActiveRecord::Base.connection_db_config.database
    assert File.exist?(db_path), "expected on-disk SQLite database at #{db_path}"

    runner = <<~RUBY
      record = Feedback.find(#{feedback.id})
      abort "missing record" unless record
      abort "wrong title" unless record.title == "Survives restart"
      abort "wrong category" unless record.category == "feature request"
      puts "ok"
    RUBY

    child_env = ENV.to_h.slice("RAILS_ENV", "TEST_ENV_NUMBER", "PARALLEL_WORKERS")
    child_env["RAILS_ENV"] ||= "test"

    stdout, stderr, status = Open3.capture3(
      { **child_env },
      "bin/rails",
      "runner",
      runner,
      chdir: Rails.root.to_s
    )

    assert status.success?, "child rails runner failed: #{stderr}#{stdout}"
    assert_equal "ok\n", stdout
  end
end
