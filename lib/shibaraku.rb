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

# active_hash do not use ActiveSupport::LazyLoadHooks
if defined?(ActiveHash)
  ActiveHash::Base.include(Shibaraku::ActiveRecordExt)
end
