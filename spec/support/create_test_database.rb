ActiveRecord::Base.establish_connection(
  YAML.load(File.read("spec/database.yml"))["test"],
)

ActiveRecord::Schema.define version: 0 do
  create_table :campaigns, force: true do |t|
    t.datetime :start_at
    t.datetime :end_at
    t.datetime :test_start_at
    t.datetime :test_end_at
  end

  create_table :events, force: true do |t|
    t.datetime :started_at
    t.datetime :ended_at
  end
end

class Campaign < ActiveRecord::Base
  shibaraku
end

class Event < ActiveRecord::Base
  shibaraku start_at: :started_at, end_at: :ended_at
end
