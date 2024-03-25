module AresMUSH
    module Tor


        def self.ratings
            [0, 1, 2, 3, 4, 5, 6]
        end

      

        def self.is_valid_rating?(rating)
            Tor.ratings.include?(rating)
        end


        def self.is_valid_skill_name?(name)
            return false if !name
            names = Global.read_config('tor', 'skills').map { |a| a['name'].downcase }
            names.include?(name.downcase)
        end


        def self.is_valid_attribute_name?(name)
            return false if !name
            names = Global.read_config('tor', 'attributes').map { |a| a['name'].downcase }
            names.include?(name.downcase)
        end

        def self.is_valid_culture_name?(name)
            return false if !name
            names = Global.read_config('tor', 'cultures').map { |a| a['name'].downcase }
            names.include?(name.downcase)
        end
            
        def self.is_valid_virtue_name?(name)
            return false if !name
            names = Global.read_config('tor', 'virtues').map { |a| a['name'].downcase }
            names.include?(name.downcase)
        end

        def self.is_valid_armour_name?(name)
            return false if !name
            names = Global.read_config('tor', 'armour').map { |a| a['name'].downcase }
            names.include?(name.downcase)
        end

        def self.is_valid_shield_name?(name)
            return false if !name
            names = Global.read_config('tor', 'shields').map { |a| a['name'].downcase }
            names.include?(name.downcase)
        end



        def self.is_valid_weapon_name?(name)
            return false if !name
            names = Global.read_config('tor', 'weapons').map { |a| a['name'].downcase }
            names.include?(name.downcase)
        end


        
        def self.can_manage_abilities?(actor)      
            return false if !actor
            actor.has_permission?("manage_apps")
        end



        def self.find_skill(model, skill_name)
            name_downcase = skill_name.downcase
            model.tor_skills.select { |a| a.name.downcase == name_downcase }.first
        end

        def self.find_virtue(model, virtue_name)
            name_downcase = virtue_name.downcase
            model.tor_virtues.select { |a| a.name.downcase == name_downcase }.first
        end


        def self.find_attribute(model, attribute_name)
            name_downcase = attribute_name.downcase
            model.tor_attributes.select { |a| a.name.downcase == name_downcase }.first
        end

        def self.find_culture(model, culture_name)
            name_downcase = culture_name.downcase
            model.tor_culture.select { |a| a.name.downcase == name_downcase }.first
        end

        def self.find_tn(model, attribute_name)
            name_downcase = attribute_name.downcase
            model.tor_tn.select { |a| a.name.downcase == name_downcase }.first
        end


        def self.find_maximum_derived_stat(model, stat_name)
            if (stat_name.downcase == "parry")
                return model.tor_parry
            end
            if (stat_name.downcase == "endurance")
                return model.tor_maxendurance
            end
            if (stat_name.downcase == "hope")
                return model.tor_maxhope
            end
            return nil
        end



        def self.find_skill_config(name)
            types = Global.read_config('tor', 'skills')
            name_downcase = name.downcase
            types.select { |a| a['name'].downcase == name.downcase }.first  
        end


        def self.find_culture_config(name)
            types = Global.read_config('tor', 'cultures')
            name_downcase = name.downcase
            types.select { |a| a['name'].downcase == name.downcase }.first
        end

        def self.find_virtue_config(name)
            types = Global.read_config('tor', 'virtues')
            name_downcase = name.downcase
            types.select { |a| a['name'].downcase == name.downcase }.first
        end

        def self.find_combat_proficiencies_config(name)
            types = Global.read_config('tor', 'starting_combat_proficiencies')
            name_downcase = name.downcase
            types.select { |a| a['name'].downcase == name.downcase }.first
        end


        def self.skill_rating(char, skill_name)
            skill = Tor.find_skill(char, skill_name)
            skill ? skill.rating : 0
        end


        def self.attribute_rating(char, attribute_name)
            attrs = Tor.find_attribute(char, attribute_name.downcase)
            attrs ? attrs.rating : 0
        end

        def self.tn_rating(char, attribute_name)
            tn = Tor.find_tn(char, attribute_name)
            tn ? tn.target_number : 0
        end

        def self.find_attribute_options_config(culture)
            options = Global.read_config('tor', 'attributes_chargen')
            name_downcase = culture.downcase
            options.select { |a| a['name'].downcase == name_downcase }.first
        end

        def self.find_derived_stats_config(culture)
            stats = Global.read_config('tor', 'derived_stats')
            name_downcase = culture.downcase
            stats.select { |a| a['name'].downcase == name_downcase }.first
        end

        def self.is_valid_attribute_options(options)
            return false if !options
            numbers = ["1", "2", "3,", "4", "5", "6"].to_s
            numbers.include?(options.downcase)
        end

        def self.find_related_attribute_name(skill)
            skill_config = Tor.find_skill_config(skill)
            return nil if !skill_config
            skill_config['linked_attribute']
        end

        def self.related_attribute_rating(char, skill)
            skill_config = Tor.find_skill_config(skill)
            return nil if !skill_config
            Tor.attribute_rating(char, skill_config['linked_attribute'])
        end

        def self.cultural_characteristics(char)
            culture = char.group("Culture").downcase
            if (culture == "bardings")
                return "Stout-hearted: Your VALOUR rolls are Favoured."
            elsif (culture == "bree-folk")
                return "Bree-blood: Each of the Bree-folk in the Company increases the Fellowship Rating by 1 point."
            elsif (culture == "dwarves of durin's folk")
                return "Redoubtable: You halve the Load rating of any armour you're wearing (rounding fractions up), including helms (but not shields).
                Naugrim: Dwarven adventurers cannot use the following pieces of war gear: great bow, great spear, and great shield."
            elsif (culture == "elves of lindon")
                return "Elven-skill: If you are not Miserable, you can spend 1 point of Hope to achieve a Magical success on a roll when using a Skill in which you possess at least one rank."    
            elsif (culture == "elves of rivendell")
                return "Elven-wise: Add 1 point to one Attribute of your choice. Additionally, if you are not Miserable, you can spend 1 point of Hope to achieve a Magical success on a skill roll.
                Beset by Woe: You can remove accumulated Shadow points exclusively during a Yule Fellowship Phase."
            elsif (culture == "hobbits of the shire")
                return "Hobbit-sense: Your WISDOM rolls are Favoured, and you gain (1d) on all Shadow Tests made to resist the effects of Greed.
                Halflings: Axe, bow, club, cudgel, dagger, short sword, short spear, spear. Additionally, Hobbits cannot use a great shield."    
            elsif (culture == "rangers of the north")
                return "Kings of Men: Add 1 point to one Attribute of your choice.
                Allegiance of the Dúnedain: During the Fellow ship phase (not Yule) you recover a maximum number of Hope points equal to half your HEART score (rounding fractions up)."
            end
        end

        def self.armour_list(char)
            list = char.tor_armour
            newlist list.to_a.sort_by { |a| a.name }
            .each_with_index
              .map do |a, i|
                if a.equipped == "Equipped"
                  if a.rewards
                    if a.origin
                      "#{a.name}: Protection: #{a.protection} Load: #{a.gearload} Origin: #{a.origin} - worn\nRewards: #{a.rewards}\n"
                    else
                      "#{a.name}: Protection: #{a.protection} Load: #{a.gearload} - worn\nRewards: #{a.rewards}\n"
                    end
                  else
                    "#{a.name}: Protection: #{a.protection} Load: #{a.gearload} - worn\n"
                  end
                elsif a.equipped == "Dropped"
                  if a.rewards
                    if a.origin
                      "#{a.name}: Protection: #{a.protection} Load: #{a.gearload} Origin: #{a.origin} - dropped\nRewards: #{a.rewards}\n"
                    else
                      "#{a.name}: Protection: #{a.protection} Load: #{a.gearload} - dropped\nRewards: #{a.rewards}\n"
                    end
                  else
                    "#{a.name}: Protection: #{a.protection} Load: #{a.gearload} - dropped\n"
                  end
                end
              end
              return newlist
        end




    end
end