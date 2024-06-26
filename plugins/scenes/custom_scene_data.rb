module AresMUSH
  module Scenes
    
    def self.custom_scene_data(viewer)
      # Return nil if you don't need any custom data.
      
      
        toradversariesarray = ["-"]


        
        Adversary.all.each do |a|
        toradversariesarray <<  a.name
        end
      
        tor_adversary_attacks_array = ["-"]
        Adversary.all.each do |a|
          tor_adversary_attacks_array << a.name + " - " + a.first_weapon_name
          tor_adversary_attacks_array << a.name + " - " + a.second_weapon_name
          tor_adversary_attacks_array << a.name + " - Armour"
        end
      
      
#       Otherwise return a hash of data.  For example, if you want to use your custom plugin's abilities, you might do:
       return {
         toradversaries: toradversariesarray,
         toradversaryattacks: tor_adversary_attacks_array
       }
    end
  end
end
