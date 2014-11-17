ActiveRecord::Base.establish_connection(
  YAML.load(File.read("spec/database.yml"))["test"],
)

ActiveRecord::Schema.define version: 0 do
  create_table :campaigns, force: true do |t|
    t.datetime :start_at
    t.datetime :end_at
  end
end

class Campaign < ActiveRecord::Base
  shibaraku
end
