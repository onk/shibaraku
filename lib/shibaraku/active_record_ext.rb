module Shibaraku
  module ActiveRecordExt
    def self.included(model)
      model.extend ClassMethods
    end

    # Class methods injected into ActiveRecord::Base
    module ClassMethods
      def shibaraku(options = {})
        include Shibaraku::ActiveRecordExt::Core
      end
    end

    module Core
      def self.included(model)
        model.extend ClassMethods
      end

      module ClassMethods
        def in_time(now = Time.current)
          where("(start_at IS NULL OR start_at <= :now) AND (end_at IS NULL OR :now < end_at)", now: now)
        end
      end

      def in_time?(now = Time.current)
        (start_at.nil? || start_at <= now) && (end_at.nil? || now < end_at)
      end

      def human_readable_end_at
        if end_at && end_at == end_at.beginning_of_day
          end_at - 1.second
        else
          end_at
        end
      end
    end
  end
end
