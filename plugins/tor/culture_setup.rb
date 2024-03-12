module AresMUSH
    module Tor
        
        
        
        def self.culture_skills(model, culture_name)
            culture = find_culture(model, culture_name)

            #This is a profoundly bad way to do this and in the very unlikely event anyone ever looks at this, don't do this.
         
            athletics = Tor.find_skill(model, "athletics")
            awareness = Tor.find_skill(model, "awareness")
            awe = Tor.find_skill(model, "awe")
            battle = Tor.find_skill(model, "battle")
            courtesy = Tor.find_skill(model, "courtesy")
            craft = Tor.find_skill(model, "craft")
            enhearten = Tor.find_skill(model, "enhearten")
            explore = Tor.find_skill(model, "explore")
            healing = Tor.find_skill(model, "healing")
            hunting = Tor.find_skill(model, "hunting")
            insight = Tor.find_skill(model, "insight")
            lore =Tor.find_skill(model, "lore")
            persuade =Tor.find_skill(model, "persuade")
            riddle = Tor.find_skill(model, "riddle")
            scan = Tor.find_skill(model, "scan")
            song =Tor.find_skill(model, "song")
            stealth =Tor.find_skill(model, "stealth")
            travel =Tor.find_skill(model, "travel")


            if (culture_name == "bardings")
                athletics.update(rating: 1)
                awe.update(rating: 1)
            end




            
           
        end
    end
end





