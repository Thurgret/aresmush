module AresMUSH
    module Tor


        def self.generate_adversary(adversary_name, adversary_type)
            config = find_adversary_config(adversary_type)
            Adversary.all.each do |a|
                if (a.name.downcase == adversary_name.downcase)
                    return nil
                end
            end
                
            Adversary.create(:name => adversary_name, :adversary_type => config['name'], :attribute_level => config['attribute_level'],
                :endurance => config['endurance'], :might => config['might'], :resolve => config['resolve'], :parry => config['parry'], :armour => config['armour'],
                :first_weapon_name => config['first_weapon_name'], :first_weapon_proficiency => config['first_weapon_proficiency'], :first_weapon_damage => config['first_weapon_damage'],
                :first_weapon_injury => config['first_weapon_injury'], :second_weapon_name => config['second_weapon_name'], 
                :second_weapon_proficiency => config['second_weapon_proficiency'], :second_weapon_damage => config['second_weapon_damage'],
                :second_weapon_injury => config['second_weapon_injury'], :fell_abilities => config['fell_abilities'])
        end


        def self.find_adversary_config(adversary_type)
            options = Global.read_config('tor', 'adversaries')
            name_downcase = adversary_type.to_s.downcase
            options.select { |a| a['name'].downcase == name_downcase }.first
        end


    end
end