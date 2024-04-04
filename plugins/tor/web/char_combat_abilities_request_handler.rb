module AresMUSH
    module Tor
      class TorCharCombatAbilitiesRequestHandler
        def handle(request)
          char = Character.find_one_by_name request.args[:id]
          
          if (!char)
            return []
          end
  
          error = Website.check_login(request, true)
          return error if error
          
            combatabilities = ["Axes", "Bows", "Spears", "Swords", "Protection"]
          
          
          
          return combatabilities
        end
      end
    end
  end
  
  
  