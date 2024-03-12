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


        end

        def self.zero_attributes(model)
            #Zero out attributes - need to be selected again when culture is changed.
            strength = Tor.find_attribute(model, "strength")
            strength.update(rating: 0)
            heart = Tor.find_attribute(model, "heart")
            heart.update(rating: 0)
            wits = Tor.find_attribute(model, "wits")
            wits.update(rating: 0)
        end  
    end
end





