require "shibaraku"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.around do |example|
    ActiveRecord::Base.transaction do
      example.run

      # テストデータを初期化するためにロールバックする
      raise ActiveRecord::Rollback
    end
  end
end

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
