module AresMUSH
    module Tor
        
        
        
        def self.culture_skills(model, culture_name)
            #model is a character
            name = culture_name.downcase
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
            if (strength)
                strength.update(rating: strength_tn)
            else
                TorTN.create(name: "strength", target_number: strength_tn, character: model)
            end
            heart = Tor.find_tn(model, "heart")
            heart_tn = 20 - Tor.attribute_rating(model, "heart")
            if (heart)
                heart.update(rating: heart_tn)
            else
                TorTN.create(name: "heart", target_number: heart_tn, character: model)                
            end
            wits = Tor.find_tn(model, "wits")
            wits_tn = 20 - Tor.attribute_rating(model, "wits")
            if (wits)
                wits.update(rating: wits_tn)
            else
                TorTN.create(name: "wits", target_number: wits_tn, character: model)
            end


        end


        def self.set_initial_derived_stats(model)
            culture = model.group("Culture").downcase
            derived_stats = find_derived_stats_config(culture)

            strength = attribute_rating(model, "strength")
            heart = attribute_rating(model, "heart")
            wits = attribute_rating(model, "wits")

            return if !derived_stats


            derived_stats.each do |stat, rating|
                if (stat.downcase == "parry")
                    rating = rating + wits
                    stat = Tor.find_maximum_derived_stat(model, "parry")
                    if stat == nil
                        tor_parry.create(rating)
                    else
                        tor_parry.update(rating)
                    end
                elsif (stat.downcase == "hope")
                    stat = Tor.find_maximum_derived_stat(model, "hope")
                    rating = rating + heart
                    if stat == nil
                        Tor.tor_maxhope.create(rating)
                        Tor.tor_hope.create(rating)
                    else
                        Tor.tor_maxhope.update(rating)
                        Tor.tor_hope.update(rating)
                    end
                elsif (stat.downcase == "endurance")
                    rating = rating + strength
                    stat = Tor.find_maximum_derived_stat(model, "endurance")
                    #if stat == nil
                     #   Tor.tor_maxendurance.create(rating)
                      #  Tor.tor_endurance.create(rating)
                    #else
                        Tor.tor_maxendurance.update(rating)
                        Tor.tor_endurance.update(rating)
                    #end
                    Global.logger.debug "Hope"
                    Global.logger.debug model.tor_maxhope
                end
            end
        end


        def self.zero_attributes(model)
            #Zero out attributes - need to be selected again when culture is changed.
            strength = Tor.find_attribute(model, "strength")
            if (strength)
                strength.update(rating: 0)
            else
                TorAttributes.create(name: "strength", rating: 0, character: model)
            end
            heart = Tor.find_attribute(model, "heart")
            if (heart)
                heart.update(rating: 0)
            else
                TorAttributes.create(name: "heart", rating: 0, character: model)                
            end
            wits = Tor.find_attribute(model, "wits")
            if (wits)
                strength.update(rating: 0)
            else
                TorAttributes.create(name: "wits", rating: 0, character: model)
            end
        end  
    end
end





