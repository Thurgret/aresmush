module AresMUSH    
    module Tor
      
        class StartingCombatProficienciesCmd
        
            include CommandHandler

          
            def handle

                
        
                ClassTargetFinder.with_a_character(enactor_name, client, enactor) do |model|
                # Get the hash of attributes out of the configuration
                culture_name = model.group("Culture").to_s
                profiencies = Tor.find_combat_proficiencies_config(culture_name)
          
                # Sort the hash and then convert it to a list of the form "Name Description"
                list = "You can select " + profiencies["options1"] + " or " + profiencies["options"] + " to have a starting rating of 2, and select any other combat proficiency, whether axes, bows, spears or swords, to have a starting rating of 1.\nAn example of the command syntax is startingcombatproficiencies/set spears/bows."
         
                  # Use the standard bordered list template to show the list with a title above it.
                  client.emit list
      
               
                end
                
            end
            
        end
       
    end
    
end