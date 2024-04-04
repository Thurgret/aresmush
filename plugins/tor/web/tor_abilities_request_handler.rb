module AresMUSH
    module Chargen
      class TorCharAbilitiesRequestHandler
        def handle(request)
          char = Character.find_one_by_name request.args[:id]
          
          if (!char)
            return []
          end
  
          error = Website.check_login(request, true)
          return error if error
          
            abilities = ["Awe", "Enhearten", "Persuade", "Athletics",
          "Travel", "Stealth", "Awareness", "Insight", "Scan", "Hunting",
        "Healing", "Explore", "Song", "Courtesy", "Riddle", "Craft",
      "Battle", "Lore", "Valour", "Wisdom", "Protection", "Axes", "Bows", "Spears", "Sword"]          
          
          return abilities
        end
      end
    end
  end
  
  
  