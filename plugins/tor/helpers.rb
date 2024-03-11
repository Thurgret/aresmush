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


        
        def self.can_manage_abilities?(actor)      
            return false if !actor
            actor.has_permission?("manage_apps")
        end



        def self.find_skill(model, skill_name)
            name_downcase = skill_name.downcase
            model.tor_skills.select { |a| a.name.downcase == name_downcase }.first
        end


        def self.find_attribute(model, attribute_name)
            name_downcase = attribute_name.downcase
            model.tor_attributes.select { |a| a.name.downcase == name_downcase }.first
        end

        def self.find_skill_config(name)
            return nil if !name
            types = Global.read_config('tor', 'skills')
            types.select { |a| a['name'].downcase == name.downcase }.first  
        end 


        def self.skill_rating(char, skill_name)
            skill = Tor.find_skill(char, skill_name)
            skill ? skill.rating : 0
        end


        def self.attribute_rating(char, attribute_name)
            attrs = Tor.find_attribute(char, attribute_name)
            attrs ? attrs.rating : 0
        end

  

    end
end