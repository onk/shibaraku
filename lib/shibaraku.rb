require "active_record"
require "shibaraku/active_record_ext"

module Shibaraku
end

ActiveRecord::Base.include(Shibaraku::ActiveRecordExt)
