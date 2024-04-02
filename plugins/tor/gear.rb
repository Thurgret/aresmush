module AresMUSH
    module Tor


        def self.add_armour(model, armour_name)
            armour = find_armour(model, armour_name)
            if (armour)
                return nil
            end
            config = find_armour_config(armour_name)
            TorArmour.create(:name => config["name"], :type => config["type"], :gearload => config["load"], :equipped => "Dropped", :protection => config["protection"], :rewards => "", :character => model)
            if (model.group("Culture").to_s.downcase == "dwarves of durin's folk")
                armour = find_armour(model, armour_name)
                new_load = (armour.gearload/2).round
                armour.update(:gearload => new_load)
            end
            wear_armour(model, armour_name)         
        end

        def self.add_weapon(model, weapon_name)
            weapon = find_weapon(model, weapon_name)
            
            Global.logger.debug weapon_name
            if (weapon)
                return nil
            end
            config = find_weapon_config(weapon_name)
            TorWeapons.create(:name => config["name"], :damage => config["damage"], :injury => config["injury"], :gearload => config["load"], :equipped => "Dropped", :proficiency => config["proficiency"], :hands => config["hands"], :wielded => "stored", :rewards => "", :character => model)
            wear_weapon(model, weapon_name)
        end

        def self.add_shield(model, shield_name)
            shield = find_shield(model, shield_name)
            if (shield)
                return nil
            end
            config = find_shield_config(shield_name)
            TorShields.create(:name => config["name"], :gearload => config["load"], :equipped => "Dropped", :parrymodifier => config["modifier"], :wielded => "stored", :rewards => "", :character => model)
            wear_shield(model, shield_name)
        end

        def self.add_weapon_reward(model, weapon_name, reward_name)
            weapon = find_weapon(model, weapon_name)
            if (reward_name.downcase == "fell")
                newstring = weapon.rewards + "Fell: Add 2 to the Injury rating of the selected weapon.
                "
                weapon.update(:rewards => newstring)
                rating = weapon.injury + 2
                weapon.update(:injury => rating)
            end
            if (reward_name.downcase == "grievous")
                newstring = weapon.rewards + "Grievous: Add 1 to the Damage rating of the selected weapon.
                "
                weapon.update(:rewards => newstring)
                rating = weapon.damage + 1
                weapon.update(:damage => rating)
            end
            if (reward_name.downcase == "keen")
                newstring = weapon.rewards + "Keen: Attack rolls made with a Keen weapon score a Piercing Blow also on a result of 9 on the Feat die.
                "
                weapon.update(:rewards => newstring)
            end
        end

        def self.add_armour_reward(model, armour_name, reward_name)
            armour = find_armour(model, armour_name)
            if (reward_name.downcase == "close-fitting")
                newstring = armour.rewards + "Close-fitting: When you make a PROTECTION roll while wearing a close- fitting armour or helm you add +2 to the result.
                "
                armour.update(:rewards => newstring)
            end
            if (reward_name.downcase == "cunning make")
                newstring = armour.rewards + "Cunning Make: Reduce the Load rating of the selected item by 2 (to a minimum of 0 Load).
                "
                if (model.group("Culture").downcase == "dwarves of durin's folk")
                    armour_config = find_armour_config(armour_name)
                    originalload = armour_config["load"].to_i
                    newload = ((originalload - 2)/2).round
                    armour.update(:gearload => newload)
                else
                    newload = armour.gearload - 2
                    armour.update(:gearload => newload)
                end
            end

        end

        def self.add_shield_reward(model, shield_name, reward_name)
            shield = find_shield(model, shield_name)
            if (reward_name.downcase == "cunning make")
                newload = shield.gearload - 2
                shield.update(:gearload => newload)
                newstring = shield.rewards + "Cunning Make: Reduce the Load rating of the selected item by 2 (to a minimum of 0 Load).
                "
                shield.update(:rewards => newstring )
            end
            if (reward_name.downcase == "reinforced")
                newparry = shield.parrymodifier + 1
                shield.update(:parrymodifier => newparry)
                newstring = shield.rewards + "Reinforced: Add 1 to your shield's Parry bonus.
                "
                shield.update(:rewards => newstring )
            end
        end









       
        def self.wear_armour(model, armour_name)
                armour = find_armour(model, armour_name)
                if (!model.wearing_armour && armour_name.downcase != "helm")
                    armour.update(:equipped => "Equipped")
                    new_load = armour.gearload + model.tor_load
                    model.update(:tor_load => new_load)
                    model.update(wearing_armour: true)
                    new_protection = model.tor_protection + armour.protection
                    model.update(:tor_protection => new_protection)
                elsif (armour_name.downcase == "helm" && !model.wearing_helm)
                    armour.update(:equipped => "Equipped")
                    new_load = armour.gearload + model.tor_load
                    model.update(:tor_load => new_load)
                    model.update(wearing_helm: true)
                    new_protection = model.tor_protection + armour.protection
                    model.update(:tor_protection => new_protection)         

                end

            end

        def self.wear_weapon(model, weapon_name)
            weapon = find_weapon(model, weapon_name)
            if (weapon.equipped == "Dropped")
                new_load = weapon.gearload + model.tor_load
                model.update(:tor_load => new_load)
                weapon.update(:equipped => "Equipped")
            end
        end

        def self.wear_shield(model, shield_name)
            shield = find_shield(model, shield_name)
            if (shield.equipped == "Dropped")
                new_load = shield.gearload + model.tor_load
                model.update(:tor_load => new_load)
                shield.update(:equipped => "Equipped")
            end
        end

        def self.remove_armour(model, armour_name)
            armour_name = armour_name.downcase
            armour = find_armour(model, armour_name)
            if (armour.equipped == "Equipped")
                armour.update(:equipped => "Dropped")
                new_load = model.tor_load - armour.gearload
                model.update(:tor_load => new_load)
                new_protection = model.tor_protection - armour.protection
                model.update(:tor_protection => new_protection)  
                if (armour_name == "helm")
                    model.update(wearing_helm: nil)
                else
                    model.update(wearing_armour: nil)
                end
            end
        end

        def self.remove_weapon(model, weapon_name)
            weapon_name = weapon_name.downcase
            weapon = find_weapon(model, weapon_name)
            if (weapon.equipped == "Equipped")
                if (weapon.wielded == "in hand")
                    store_weapon(model, weapon_name)
                end
                new_load = model.tor_load - weapon.gearload
                model.update(:tor_load => new_load)
                weapon.update(:equipped => "Dropped")
            end
        end

        def self.remove_shield(model, shield_name)
            shield_name = shield_name.downcase
            shield = find_shield(model, shield_name)
            if (shield.equipped == "Equipped")
                if (shield.wielded == "in hand")
                    store_shield(model, shield_name)
                end
                new_load = model.tor_load - shield.gearload
                model.update(:tor_load => new_load)           
                shield.update(:equipped => "Dropped")
            end
        end

        def self.discard_armour(model, armour_name)
            armour_name = armour_name.downcase
            armour = find_armour(model, armour_name)
            if (armour.equipped == "Equipped")
                remove_armour(model, armour_name)
            end
            armour.delete
        end

        def self.discard_shield(model, shield_name)
            name_downcase = shield_name.downcase
            shield = find_shield(model, shield_name)
            if (shield.wielded == "in hand")
                store_shield(model, name_downcase)
            end
            if (shield.equipped == "Equipped")
                remove_shield(model, name_downcase)
            end
            shield.delete
        end

        def self.discard_weapon(model, weapon_name)
            weapon = find_weapon(model, weapon_name)
            if (weapon.wielded == "in hand")
                store_weapon(model, weapon_name)
            end
            if (weapon.equipped == "Equipped")
                remove_weapon(model, weapon_name)
            end
            weapon.delete
        end

        def self.wield_weapon(model, weapon_name)
            weapon = find_weapon(model, weapon_name)
            config = find_weapon_config(weapon_name)
            if (model.first_hand_in_use)
                return nil
            end
            if (!model.second_hand_in_use)
                
                if(weapon.hands == "either")    
                    two_handed_injury = weapon.injury + 2
                    weapon.update(:injury => two_handed_injury)
                    model.update(:second_hand_in_use => "yes")
                elsif(weapon.hands == "both")
                    model.update(:second_hand_in_use => "yes")
                
                end
            end
            model.update(:first_hand_in_use => "yes")           
            weapon.update(:wielded => "in hand")
          
        end

        def self.store_weapon(model, weapon_name)
            weapon = find_weapon(model, weapon_name)
            if (weapon.wielded == "in hand")
                config = find_weapon_config(weapon_name)
                 if (!model.shield_in_use && model.second_hand_in_use)
                    rating = weapon.injury - 2
                    weapon.update(:injury => rating)
                    model.update(:second_hand_in_use => nil)
                end
                model.update(:first_hand_in_use => nil)
                weapon.update(:wielded => "stored")
            else
                return nil
            end
        end


            

        def self.hold_shield(model, shield_name)
            shield = find_shield(model, shield_name)
            config = find_shield_config(shield_name)
            if (model.second_hand_in_use)
                return nil
            else
                shield.update(:wielded => "in hand")
                model.update(:second_hand_in_use => "yes")
                model.update(:shield_in_use => "yes")
                rating = model.tor_parry + shield.parrymodifier
                model.update(:tor_parry => rating)
            end
        end

        def self.store_shield(model, shield_name)
            if (model.shield_in_use)
                shield = find_shield(model, shield_name)
                model.update(:second_hand_in_use => nil)
                model.update(:shield_in_use => nil)
                shield.update(:wielded => "stored") 
                rating = model.tor_parry - shield.parrymodifier
                model.update(:tor_parry => rating)
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