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

      def shibaraku_start_at_column_name(user)
        name = self.shibaraku_start_at_column
        name = test_column_name(name) if user && user.super_user?
        name
      end

      def shibaraku_end_at_column_name(user)
        name = self.shibaraku_end_at_column
        name = test_column_name(name) if user && user.super_user?
        name
      end

      def test_column_name(name)
        define_attribute_methods
        test_name = "test_#{name}"
        self.method_defined?(test_name) ? test_name : name
      end
    end

    module Core
      def self.included(model)
        model.extend ClassMethods
      end

      def shibaraku_start_at(user)
        public_send(self.class.shibaraku_start_at_column_name(user))
      end

      def shibaraku_end_at(user)
        public_send(self.class.shibaraku_end_at_column_name(user))
      end

      module ClassMethods
        def in_time(user = nil, now = Time.current)
          start_at = shibaraku_start_at_column_name(user)
          end_at   = shibaraku_end_at_column_name(user)
          where("(#{start_at} IS NULL OR #{start_at} <= :now) AND (#{end_at} IS NULL OR :now < #{end_at})", now: now)
        end
      end

      def in_time?(user = nil, now = Time.current)
        (shibaraku_start_at(user).nil? || shibaraku_start_at(user) <= now) && (shibaraku_end_at(user).nil? || now < shibaraku_end_at(user))
      end

      def human_readable_end_at(user = nil)
        if shibaraku_end_at(user) && shibaraku_end_at(user) == shibaraku_end_at(user).beginning_of_day
          shibaraku_end_at(user) - 1.second
        else
          shibaraku_end_at(user)
        end
      end
    end
  end
end
