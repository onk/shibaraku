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

  create_table :users, force: true do |t|
    t.string   :name, null: false
  end
  create_table :departments, force: true do |t|
    t.string   :name, null: false
    t.datetime :start_at
    t.datetime :end_at
  end
  create_table :user_departments, force: true do |t|
    t.integer  :user_id,       null: false
    t.integer  :department_id, null: false
    t.datetime :start_at
    t.datetime :end_at
    t.index    [:user_id, :department_id]
  end
end

class Campaign < ActiveRecord::Base
  shibaraku
end

class Event < ActiveRecord::Base
  shibaraku start_at: :started_at, end_at: :ended_at
end

class User < ActiveRecord::Base
  has_many :user_departments
  has_many :current_user_departments, -> { in_time }, class_name: "UserDepartment"
  has_many :departments, through: :user_departments
  has_many :current_departments, through: :current_user_departments, source: :department
end

class Department < ActiveRecord::Base
  shibaraku
  has_many :user_departments
  has_many :current_user_departments, -> { in_time }, class_name: "UserDepartment"
  has_many :users, through: :user_departments
  has_many :current_users, through: :current_user_departments, source: :user
end

class UserDepartment < ActiveRecord::Base
  shibaraku
  belongs_to :user
  belongs_to :department
end
