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

        def self.select_attributes(model, option)
            culture = model.group("Culture").downcase
            attributes = find_attribute_options_config(culture)

            return if !attributes

            number = option.to_i
            attributes[number].each do |attrs, rating|
                attrs = Tor.find_attribute(model, attrs)
                attrs.update(rating: rating)
            end
        end

        def self.set_initial_tn(model)
            strength = Tor.find_tn(model, "strength")
            strength_tn = 20 - Tor.attribute_rating(model, "strength")
            if (!strength)
                TorTN.create(name: "strength", target_number: strength_tn, model: model)
            else
                strength.update(rating: strength_tn)
            end
            Global.logger.debug strength_tn
            heart = Tor.find_tn(model, "heart")
            heart_tn = 20 - Tor.attribute_rating(model, "heart")
            if (!heart)
                TorTN.create(name: "heart", target_number: heart_tn, model: model)
            else
                heart.update(rating: heart_tn)
            end
            wits = Tor.find_tn(model, "wits")
            wits_tn = 20 - Tor.attribute_rating(model, "wits")
            if (!wits)
                TorTN.create(name: "wits", target_number: wits_tn, model: model)
            else
                wits.update(rating: wits_tn)
            end


        end


        def self.zero_attributes(model)
            #Zero out attributes - need to be selected again when culture is changed.
            strength = Tor.find_attribute(model, "strength")
            if (!strength)
                TorAttributes.create(name: "strength", rating: 0, character: model)
            else
                strength.update(rating: 0)
            end
            heart = Tor.find_attribute(model, "heart")
            if (!strength)
                TorAttributes.create(name: "heart", rating: 0, character: model)
            else
                strength.update(rating: 0)
            end
            strength = Tor.find_attribute(model, "wits")
            if (!strength)
                TorAttributes.create(name: "wits", rating: 0, character: model)
            else
                strength.update(rating: 0)
            end
        end  
    end
end





