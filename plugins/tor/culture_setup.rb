module AresMUSH
    module Tor
        
        
        
        def self.culture_skills(model, culture_name)
            #model is a character
            name = culture_name.downcase
            culture = find_culture(model, name)


            culture_config = find_culture_config(name)
            return if !culture_config

            culture_config["starting_skills"].each do |skill, rating|
                skill = Tor.find_skill(model, skill)
                skill.update(rating: rating)
            end


            #Zero out attributes - need to be selected again when culture is changed.
            model.update(heart: 0)
            model.update(wits: 0)
            model.update(strength: 0)
           
        end

        def self.zero_attributes(model)
            #Zero out attributes - need to be selected again when culture is changed.
            model.update(heart: 0)
            model.update(wits: 0)
            model.update(strength: 0)          
        end  
    end
end





