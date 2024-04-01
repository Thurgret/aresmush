module AresMUSH
    module Tor
      class CharSetInitialCulture
        def on_event(event)
           char = Character[event.char_id]
           Demographics.set_group(model, "Culture", "Hobbits of the Shire")
           Demographics.set_group(model, "Calling", "Treasure Hunter")
           Tor.initial_setup(char)
        end
      end
    end
  end