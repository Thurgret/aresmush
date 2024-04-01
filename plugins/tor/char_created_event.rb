module AresMUSH
    module Tor
      def self.get_event_handler(event_name) 
        Global.logger.debug event_name
        case event_name
        when "CharCreatedEvent"
          return CharCreatedEventHandler
        end
        nil
      end
    end
  end