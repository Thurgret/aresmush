module AresMUSH
  module Scenes
    
    def self.custom_scene_data(viewer)
      # Return nil if you don't need any custom data.
      
      
        torcombatabilitiesarray = ["Axes", "Bows", "Spears", "Swords", "Protection"]


        
        Adversary.each do |a|
        torcombatabilitiesarray <<  a.name
        end
      
      
      
#       Otherwise return a hash of data.  For example, if you want to use your custom plugin's abilities, you might do:
       return {
         torcombatabilities: torcombatabilitiesarray
       }
    end
  end
end
