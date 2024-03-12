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
    end
end





