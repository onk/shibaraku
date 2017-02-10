require "active_record"
begin
  require "active_hash"
rescue LoadError
end
require "shibaraku/active_record_ext"

module Shibaraku
end

ActiveSupport.on_load :active_record do
  ActiveRecord::Base.include(Shibaraku::ActiveRecordExt)
end
ActiveSupport.on_load :active_hash do
  ActiveHash::Base.include(Shibaraku::ActiveRecordExt)
end
