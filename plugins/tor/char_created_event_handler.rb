module AresMUSH
    module Tor
      class CharCreatedEventHandler
        def on_event(event)
           char = Character[event.char_id]
           Demographics.set_group(char, "Culture", "Hobbits of the Shire")
           Demographics.set_group(char, "Calling", "Treasure Hunter")
           Tor.initial_setup(char)
        end
      end
    end
  end