module AresMUSH
    module Tor


        def self.add_armour(model, armour_name)
            armour = find_armour(armour_name)
            if (armour)
                return nil
            end
            config = find_armour_config(armour_name)
            TorArmour.create(:name => config['name'], :type => config['type'], :gearload => config['gearload'], :protection => config['protection'])            
        end

        def self.discard_armour(model, armour_name)
            armour = find_armour(armour_name)
            armour.delete
        end

        def self.find_armour_config(armour_name)
            stats = Global.read_config('tor', 'armour')
            name_downcase = culture.downcase
            stats.select { |a| a['name'].downcase == name_downcase }.first
        end


        
        def self.find_armour(model, armour_name)
            name_downcase = armour_name.downcase
            model.tor_armour.select { |a| a.name.downcase = name_downcase }.first
        end


    end
end