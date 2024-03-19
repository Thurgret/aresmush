module AresMUSH
    module Tor


        def self.add_armour(model, armour_name)
            armour = find_armour(model, armour_name)
            if (armour)
                return nil
            end
            config = find_armour_config(armour_name)
            TorArmour.create(:name => config["name"], :type => config["type"], :gearload => config["load"], :protection => config["protection"], :character => model)           
        end

        def self.add_weapon(model, weapon_name)
            weapon = find_weapon(model, weapon_name)
            if (weapon)
                return nil
            end
            config = find_weapon_config(weapon_name)
            TorWeapon.create(:name => config["name"], :damage => config["damage"], :injury => config["injury"], :gearload => config["load"], :proficiency => config["proficiency"], :hands => config["hands"])
        end

        def self.add_shield(model, weapon_name)
            shield = find_shield(model, weapon_name)
            if (shield)
                return nil
            end
            config = find_shield_config(shield_name)
            TorWeapon.create(:name => config["name"], :gearload => config["load"], :modifier => config["modifier"])
        end

        def self.wear_armour(model, armour_name)
            armour = find_armour(model, armour_name)
            armour.update(:equipped => "Equipped")
        end

        def self.wear_weapon(model, weapon_name)
            weapon = find_weapon(model, weapon_name)
            weapon.update(:equipped => "Equipped")
        end

        def self.wear_shield(model, shield_name)
            shield = find_shield(model, shield_name)
            shield.update(:equipped => "Equipped")
        end

        def self.remove_armour(model, armour_name)
            armour = find_armour(model, armour_name)
            armour.update(:equipped => "Dropped")
        end

        def self.remove_weapon(model, weapon_name)
            weapon = find_weapon(model, weapon_name)
            weapon.update(:equipped => "Dropped")
        end

        def self.remove_shield(model, shield_name)
            weapon = find_shield(model, shield_name)
            shield.update(:equipped => "Dropped")
        end

        def self.discard_armour(model, armour_name)
            armour = find_armour(model, armour_name)
            armour.delete
        end

        def self.wield_weapon(model, weapon_name)
            weapon = find_weapon(model, weapon_name)
            config = find_weapon_config(weapon_name)
            if (model.first_hand_in_use)
                return nil
            end
            if (model.second_hand_in_use)
                if (weapon["hands"] == "both")
                    return nil
                elsif(weapon["hands"] == "either")
                    weapon.update(:injury => weapon["injury"])
                    
            else
                if(weapon["hands"] == "either")
                    two_handed_injury = weapon["injury"] + 2
                    weapon.update(:injury => two_handed_injury)
                    model.update(:second_hand_in_use => true)
                elsif(weapon["hands"] == "both")
                    model.update(:second_hand_in_use => true)
                end
            end
            model.update(:first_hand_in_use => true)           
            weapon.update(:wielded => "in hand")
          
        end

        def self.store_weapon(model, weapon_name)
            weapon = find_weapon(model, weapon_name)
            config = find_weapon_config(weapon_name)
            weapon.update(:injury => config["injury"])
            if (!model.shield_in_use)
                model.update(:second_hand_in_use => false)
            end
            model.update(:first_hand_in_use => false)
            weapon.update(:wielded => "stored")
        end


            

        def self.hold_shield(model, shield_name)
            shield = find_shield(model, shield_name)
            config = find_shield_config(shield_name)
            if (model.second_hand_in_use)
                return nil
            else
                shield.update(:wielded => "in hand")
                model.update(:second_hand_in_use => true)
                model.update(:shield_in_use => true)
                model.parry = model.parry + shield["modifier"]
            end
        end

        def self.store_shield(model, shield_name)
            if (model.shield_in_use)
                shield = find_shield(model, shield_name)
                model.update(:second_hand_in_use => false)
                shield.update(:wielded => "stored") 
                model.parry = model.parry - shield["modifier"]
            else
                return nil
            end
        end


        def self.find_armour_config(armour_name)
            stats = Global.read_config('tor', 'armour')
            name_downcase = armour_name.downcase
            stats.select { |a| a['name'].downcase == name_downcase }.first
        end

        def self.find_weapon_config(weapon_name)
            stats = Global.read_config('tor', 'weapons')
            name_downcase = weapon_name.downcase
            stats.select { |a| a['name'].downcase == name_downcase }.first
        end

        def self.find_shield_config(shield_name)
            stats = Global.read_config('tor', 'shields')
            name_downcase = shield_name.downcase
            stats.select { |a| a['name'].downcase == name_downcase }.first
        end


        
        def self.find_armour(model, armour_name)
            name_downcase = armour_name.downcase
            model.tor_armour.select { |a| a.name.downcase == name_downcase }.first
        end

        def self.find_weapon(model, weapon_name)
            name_downcase = weapon_name.downcase
            model.tor_weapons.select { |a| a.name.downcase == name_downcase }.first
        end

        def self.find_shield(model, shield_name)
            name_downcase = shield_name.downcase
            model.tor_shields.select { |a| a.name.downcase == name_downcase }.first
        end



    end
end