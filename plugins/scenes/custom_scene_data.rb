module AresMUSH
  module Scenes
    
    def self.custom_scene_data(viewer)
      # Return nil if you don't need any custom data.
      
      
        toradversaries = ["-"]


        
        Adversary.all.each do |a|
        toradversaries <<  a.name
        end
      
      
      
#       Otherwise return a hash of data.  For example, if you want to use your custom plugin's abilities, you might do:
       return {
         toradversaries: torcombatabilitiesarray
       }
    end
  end
end
