module AresMUSH
    module Tor
      def self.get_event_handler(event_name) 
        case event_name
        when "CharCreatedEvent"
          return CharSetInitialCulture
        end
        nil
      end
    end
  end