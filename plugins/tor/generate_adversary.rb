module AresMUSH
    module Tor


        def self.generate_adversary(adversary_name, adversary_type)
            if (adversary_type.downcase == "southerner raider")
                Adversary.create(:name => adversary_name, :adversary_type => adversary_type, :attribute_level => 4,
                :endurance => 16, :might => 1, :resolve => 4, :parry => 1, :armour => 2,
                :first_weapon_name => "Axe", :first_weapon_proficiency => 3, :first_weapon_damage => 5,
                :first_weapon_injury => 18, :second_weapon_name => "Short Spear", 
                :second_weapon_proficiency => 2, :second_weapon_damage => 3,
                :second_weapon_injury => 14)
            end
        end


    end
end