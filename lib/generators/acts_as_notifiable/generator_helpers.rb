module ActsAsNotifiable
  module Generators
    module GeneratorHelpers
      def valid_notification_file_name
        if file_name =~ /_notification$/
          file_name
        else
          file_name + '_notification'
        end
      end

      def valid_notification_class_name
        if class_name =~ /Notification$/
          class_name
        else
          class_name + 'Notification'
        end
      end
    end
  end
end
