require "active_record"
require "shibaraku/active_record_ext"

module Shibaraku
end

ActiveSupport.on_load :active_record do
  ActiveRecord::Base.include(Shibaraku::ActiveRecordExt)
end
