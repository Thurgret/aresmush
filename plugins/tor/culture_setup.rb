module AresMUSH
    module Tor

        def self.initial_setup(model)
            culture_name = model.group("Culture")            
            culture = Tor.find_culture(model, culture_name)
             
            if (culture)
                culture.update(name: culture_name)
            else
                TorCulture.create(name: culture_name, character: model)    
            end

            model.update(:first_hand_in_use => nil)
            model.update(:second_hand_in_use => nil)

            model.update(favoured_skills: "")
            model.update(distinctive_features: "")

            Tor.set_starting_treasure(model)

            Tor.remove_starting_virtues(model)
            Tor.select_attributes(model, "5")            
            Tor.set_valour(model, 1)
            Tor.set_wisdom(model, 1)
            Tor.add_shadow(model, 0)
            Tor.add_shadowscars(model, 0)
            Tor.add_adventure_points(model, 0)
            Tor.add_skill_points(model, 0)
            Tor.culture_skills(model, culture_name)
            Tor.set_initial_derived_stats(model)

            proficiency_config = Tor.find_combat_proficiencies_config(culture_name)

            Tor.set_combat_proficiency(model, proficiency_config["option1"], 2)
            Tor.set_combat_proficiency(model, proficiency_config["option2"], 1)
        end
    
        
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

            Tor.remove_starting_virtues(model)
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
            Tor.set_initial_derived_stats(model)
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
            model.update(:tor_valour => rating)
        end

        def self.set_wisdom(model, rating)
            model.update(:tor_wisdom => rating)
            if (rating > 2)
                virtue = Tor.find_virtue(model, "hardiness")
                if (virtue)
                    current_endurance = model.tor_maxendurance
                    new_endurance = current_endurance + 1
                    model.update(:tor_maxendurance => new_endurance)
                    model.update(:tor_endurance => model.tor_maxendurance)
                end
            end
        end

        def self.set_combat_proficiency(model, proficiency, rating)
            if (proficiency.downcase == "axes")
                model.update(:tor_axes_proficiency => rating)
            end
            if (proficiency.downcase == "bows")
                model.update(:tor_bows_proficiency => rating)
            end
            if (proficiency.downcase == "spears")
                model.update(:tor_spears_proficiency => rating)
            end
            if (proficiency.downcase == "swords")
                model.update(:tor_swords_proficiency => rating)
            end
        end


        def self.add_shadow(model, rating)
            newrating = model.tor_shadow + rating
            model.update(:tor_shadow => newrating)
            totalrating = model.tor_shadowtotal + rating
            model.update(:tor_shadow => totalrating)
        end

        def self.add_shadowscars(model, rating)
            newrating = model.tor_shadowscars + rating
            model.update(:tor_shadowscars => newrating)
            totalrating = model.tor_shadowtotal + rating
            model.update(:tor_shadowtotal => totalrating)
        end

        def self.add_adventure_points(model, rating)
            newrating = model.tor_adventure_points + rating
            model.update(:tor_adventure_points => newrating)
            lifetimeadjustment = model.tor_lifetime_adventure_points + rating
            model.update(:tor_lifetime_adventure_points => lifetimeadjustment)
        end

        def self.add_skill_points(model, rating)
            newrating = model.tor_skill_points + rating
            model.update(:tor_skill_points => newrating)
            lifetimeadjustment = model.tor_lifetime_skill_points + rating
            model.update(:tor_lifetime_skill_points => lifetimeadjustment)
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
                if (virtue_name.downcase == "confidence")
                    rating = model.tor_maxhope - 2
                    model.update(:tor_maxhope => rating)
                    model.update(:tor_hope => rating)
                elsif (virtue_name.downcase == "hardiness")
                    rating = model.tor_maxendurance - 2
                    model.update(:tor_maxendurance => rating)    
                    model.update(:tor_endurance => rating)
                elsif (virtue_name.downcase == "nimbleness")
                    rating = model.tor_parry - 1
                    model.update(:tor_parry => rating)
               
                end
                virtue.delete
            else
                virtue_config = Tor.find_virtue_config(virtue_name)
                virtue_culture = virtue_config["culture"]
                
                if (virtue_culture.downcase != model.group("Culture").downcase && virtue_culture.downcase != "everyone")
                    if (model.group("Culture").downcase == "elves of rivendell" && virtue_culture.downcase == "elves of lindon")
                    else
                        return nil
                    end
                end
                if (virtue_name.downcase == "confidence")
                    rating = model.tor_maxhope + 2
                    model.update(:tor_maxhope => rating)
                    model.update(:tor_hope => rating)
                elsif (virtue_name.downcase == "hardiness")
                    rating = model.tor_maxendurance + 2
                    model.update(:tor_maxendurance => rating)
                    model.update(:tor_endurance => rating)
                elsif (virtue_name.downcase == "nimbleness")
                    rating = model.tor_parry + 1
                    model.update(:tor_parry => rating)
                end
                virtue_desc = virtue_config["desc"]
                TorVirtues.create(name: virtue_name, desc: virtue_desc, character: model)
            end
        end

        def self.remove_starting_virtues(model)
            virtue = Tor.find_virtue(model, "confidence")
            if (virtue)
                rating = model.tor_maxhope - 2
                model.update(:tor_maxhope => rating)
                model.update(:tor_hope => rating)
                virtue.delete
            end
            virtue = Tor.find_virtue(model, "dour-handed")
            if (virtue)
                virtue.delete
            end
            virtue = Tor.find_virtue(model, "hardiness")
            if (virtue)
                rating = model.tor_maxendurance - 2
                model.update(:tor_maxendurance => rating)    
                model.update(:tor_endurance => rating)
                virtue.delete
            end
            virtue = Tor.find_virtue(model, "mastery")
            if (virtue)
                virtue.delete
            end
            virtue = Tor.find_virtue(model, "nimbleness")
            if (virtue)

                rating = model.tor_parry + 1
                model.update(:tor_parry => rating)
                virtue.delete
            end
            virtue = Tor.find_virtue(model, "prowess")
            if (virtue)
                virtue.delete
            end
            

        end

        def self.zero_combat_proficiencies(model)
            Tor.set_combat_proficiency(model, "axes", 0)
            Tor.set_combat_proficiency(model, "bows", 0)
            Tor.set_combat_proficiency(model, "spears", 0)
            Tor.set_combat_proficiency(model, "swords", 0)

        end

        def self.update_favoured_skills(model, skills)
            model.update(:favoured_skills => skills)
            Global.logger.debug model.favoured_skills
        end
            
        def self.set_distinctive_features(model, first_distinctive_feature, second_distinctive_feature)
            newstring = calling_distinctive_feature(model) + ", " + first_distinctive_feature + ", " + second_distinctive_feature
            model.update(distinctive_features: newstring)
        end

        def self.set_starting_treasure(model)
            culture = model.group("Culture").to_s.downcase
            if (culture == "elves of lindon" || culture == "rangers of the north")
                model.update(treasure: 0)
            elsif (culture == "hobbits of the shire" || culture == "bree-folk")
                model.update(treasure: 30)
            else
                model.update(treasure: 90)
            end
        end

  
    end
end





