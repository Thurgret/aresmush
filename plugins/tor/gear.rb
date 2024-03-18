module AresMUSH
    module Tor


        def self.add_armour(model, armour_name)
            armour = find_armour(model, armour_name)
            if (armour)
                return nil
            end
            config = find_armour_config(armour_name)
            Global.logger.debug "Creating armour"
            Global.logger.debug config
            name = config["name"]
            type = config["type"]
            Global.logger.debug name
            Global.logger.debug type
            TorArmour.create(:name => config["name"], :type => config["type"], :gearload => config["load"], :protection => config["protection"], :character => model)           

        end

        def self.discard_armour(model, armour_name)
            armour = find_armour(armour_name)
            armour.delete
        end

        def self.find_armour_config(armour_name)
            stats = Global.read_config('tor', 'armour')
            name_downcase = armour_name.downcase
            stats.select { |a| a['name'].downcase == name_downcase }.first
        end


        
        def self.find_armour(model, armour_name)
            name_downcase = armour_name.downcase
            model.tor_armour.select { |a| a.name.downcase == name_downcase }.first
        end


    end
end