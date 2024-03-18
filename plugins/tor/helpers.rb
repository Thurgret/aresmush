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

        def self.is_valid_armour_name(name)
            return false if !name
            names = Global.read_config('tor', 'armour').map { |a| a['name'].downcase }
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




    end
end