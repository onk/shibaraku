module Shibaraku
  module ActiveRecordExt
    def self.included(model)
      model.class_eval {
        class_attribute :shibaraku_start_at_column
        class_attribute :shibaraku_end_at_column
      }
      model.extend ClassMethods
    end

    # Class methods injected into ActiveRecord::Base
    module ClassMethods
      def shibaraku(options = {})
        self.shibaraku_start_at_column = options[:start_at] || :start_at
        self.shibaraku_end_at_column   = options[:end_at]   || :end_at
        include Shibaraku::ActiveRecordExt::Core
      end
    end

    module Core
      def self.included(model)
        model.extend ClassMethods
      end

      def shibaraku_start_at
        public_send(self.class.shibaraku_start_at_column)
      end

      def shibaraku_end_at
        public_send(self.class.shibaraku_end_at_column)
      end

      module ClassMethods
        def in_time(now = Time.current)
          start_at = shibaraku_start_at_column
          end_at   = shibaraku_end_at_column
          where("(#{start_at} IS NULL OR #{start_at} <= :now) AND (#{end_at} IS NULL OR :now < #{end_at})", now: now)
        end
      end

      def in_time?(now = Time.current)
        (shibaraku_start_at.nil? || shibaraku_start_at <= now) && (shibaraku_end_at.nil? || now < shibaraku_end_at)
      end

      def human_readable_end_at
        if shibaraku_end_at && shibaraku_end_at == shibaraku_end_at.beginning_of_day
          shibaraku_end_at - 1.second
        else
          shibaraku_end_at
        end
      end
    end
  end
end
