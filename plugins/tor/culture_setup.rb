module AresMUSH
    module Tor

        def self.initial_setup(model)
            culture_name = model.group("Culture")            
            culture = Tor.find_culture(model, culture_name)

            Global.logger.debug "" + model.group("Culture").downcase
                
            if (culture)
                culture.update(name: culture_name)
            else
                TorCulture.create(name: culture_name, character: model)    
            end
            Tor.select_attributes(model, "5")            
            Tor.set_valour(model, 1)
            Tor.set_wisdom(model, 1)
            Tor.culture_skills(model, culture_name)
            Tor.set_initial_derived_stats(model)
        end
    
        
        def self.culture_skills(model, culture_name)
            #model is a character

            name = culture_name.downcase
            culture_config = find_culture_config(name)
            return if !culture_config

            culture_config["starting_skills"].each do |skill, rating|
                Global.logger.debug "Setting skill to" +rating.to_s
                skill = Tor.find_skill(model, skill)
                skill.update(rating: rating)
            end
        end

        def self.select_attributes(model, option)
            Global.logger.debug "test"

            culture = model.group("Culture").downcase

            attributes = find_attribute_options_config(culture)

            return if !attributes

            number = option.to_i
            attributes[number].each do |attrs, rating|
                current_attribute = Tor.find_attribute(model, attrs)
                if (current_attribute)
                    current_attribute.update(rating: rating)
                else
                    TorAttributes.create(name: attrs, rating: rating, character: model)
                end
            end
            Tor.set_initial_tn(model)
        end

        def self.set_initial_tn(model)
            strength = Tor.find_tn(model, "strength")
            strength_tn = 20 - Tor.attribute_rating(model, "strength")
            if (strength)
                strength.update(:target_number => strength_tn)
            else
                TorTN.create(name: "strength", target_number: strength_tn, character: model)
            end
            heart = Tor.find_tn(model, "heart")
            heart_tn = 20 - Tor.attribute_rating(model, "heart")
            if (heart)
                heart.update(:target_number => heart_tn)
            else
                TorTN.create(name: "heart", target_number: heart_tn, character: model)                
            end
            wits = Tor.find_tn(model, "wits")
            wits_tn = 20 - Tor.attribute_rating(model, "wits")
            if (wits)
                wits.update(:target_number => wits_tn)
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
                        model.create(:tor_parry => rating)
                    else
                        model.update(:tor_parry => rating)
                    end
                elsif (stat.downcase == "hope")
                    stat = Tor.find_maximum_derived_stat(model, "hope")
                    rating = rating + heart
                    if stat == nil
                        model.create(:tor_maxhope => rating)
                        model.create(:tor_hope => rating)
                    else
                        model.update(:tor_maxhope => rating)
                        model.update(:tor_hope => rating)
                    end
                elsif (stat.downcase == "endurance")
                    rating = rating + strength
                    stat = Tor.find_maximum_derived_stat(model, "endurance")
                    if stat == nil
                        model.create(:tor_maxendurance => rating)
                        model.create(:tor_endurance => rating)
                    else
                        model.update(:tor_maxendurance => rating)
                        model.update(:tor_endurance => rating)
                    end
                end
            end
        end

        def self.set_valour(model, rating)
            if (model.tor_valour == nil)
                model.create(:tor_valour => rating)
            else
                model.update(:tor_valour => rating)
            end
        end

        def self.set_wisdom(model, rating)
            if (model.tor_wisdom == nil)
                model.create(:tor_wisdom => rating)
            else
                model.update(:tor_wisdom => rating)
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
                wits.update(rating: 0)
            else
                TorAttributes.create(name: "wits", rating: 0, character: model)
            end
        end  

        def self.virtue_set(model, virtue_name)
            virtue = Tor.find_virtue(model, virtue_name)
            if (virtue)
                virtue.delete
            else
                virtue_config = Tor.find_virtue_config(virtue_name)
                virtue_desc = virtue_config["desc"]
                Global.logger.debug virtue_config
                TorVirtues.create(name: virtue_name, desc: virtue_desc, character: model)
            end
        end

  
    end
end





