暫
================================

ActiveRecord で start_at/end_at がある model を扱う gem です


Usage
--------------------------------

```ruby
# create_table :campaigns do |t|
#   t.datetime :start_at
#   t.datetime :end_at
# end
class Campaign < ActiveRecord::Base
  shibaraku
end
```

```ruby
Campaign.in_time
# => select start_at <= now < end_at records
```

```ruby
campaign = Campaign.create(start_at: 1.hour.ago, end_at: 1.hour.since)
campaign.in_time? # => true
```

