module AresMUSH
    class Character < Ohm::Model
    
        
    
    
        collection :tor_culture, "AresMUSH::TorCulture"
        attribute :tor_calling
        
        
        collection :tor_attributes, "AresMUSH::TorAttributes"
        collection :tor_skills, "AresMUSH::TorSkills"
        collection :tor_tn, "AresMUSH::TorTN"
        collection :tor_virtues, "AresMUSH::TorVirtues"
        ##collection :tor_rewards, "AresMUSH::TorRewards"
        ##collection :tor_distinctivefeatures, "AresMUSH::TorDistinctiveFeatures"
        collection :tor_armour, "AresMUSH::TorArmour"
        collection :tor_weapons, "AresMUSH::TorWeapons"
        collection :tor_shields, "AresMUSH::TorShields"
        
        attribute :tor_adventure_points, :type => DataType::Integer
        attribute :tor_skill_points, :type => DataType::Integer

        attribute :tor_lifetime_adventure_points, :type => DataType::Integer
        attribute :tor_lifetime_skill_points, :type => DataType::Integer
        
        attribute :tor_wisdom, :type => DataType::Integer
        attribute :tor_valour, :type => DataType::Integer
        
        attribute :tor_maxhope, :type => DataType::Integer
        attribute :tor_hope, :type => DataType::Integer
        
        attribute :tor_shadow, :type => DataType::Integer
        attribute :tor_shadowscars, :type => DataType::Integer
        attribute :tor_shadowtotal, :type => DataType::Integer
        
        attribute :tor_maxendurance, :type => DataType::Integer
        attribute :tor_endurance, :type => DataType::Integer
        
        attribute :tor_parry, :type => DataType::Integer

        attribute :tor_axes_proficiency, :type => DataType::Integer
        attribute :tor_bows_proficiency, :type => DataType::Integer
        attribute :tor_spears_proficiency, :type => DataType::Integer
        attribute :tor_swords_proficiency, :type => DataType::Integer

        attribute :tor_protection, :type => DataType::Integer
        attribute :tor_load, :type => DataType::Integer

        attribute :first_hand_in_use
        attribute :second_hand_in_use

        attribute :shield_in_use
        
        #attribute :treasure, :type => DataType::Integer
        #attribute :treasure_carried, :type => DataType::Integer
  
  
        before_delete :delete_tor_abilities



        #self.tor_distinctivefeatures, self.tor_tn, self.tor_combatproficiencies,
         # self.tor_virtues, self.tor_rewards, self.tor_armour, self.tor_weapons, self.tor_shields
      
      def delete_tor_abilities
        [ self.tor_skills, self.tor_attributes, self.tor_culture, self.tor_tn, self.tor_maxhope, self.tor_hope, self.tor_maxendurance,
          self.tor_endurance, self.tor_parry, self.tor_virtues  ].each do |list|
          list.each do |a|
            a.delete
          end
        end
      end
    end


    class TorAttributes < Ohm::Model
        include ObjectModel
        
        attribute :name
        attribute :desc
        attribute :rating, :type => DataType::Integer
        reference :character, "AresMUSH::Character"
        index :name
        
    end



    class TorSkills < Ohm::Model
        include ObjectModel
        
        attribute :name
        attribute :desc
        attribute :rating, :type => DataType::Integer
        reference :character, "AresMUSH::Character"
        index :name
        
    end


    class TorCulture < Ohm::Model
          include ObjectModel

          attribute :name
          attribute :desc

          reference :character, "AresMUSH::Character"
          index :name
    end



   
    
    class TorTN < Ohm::Model
      include ObjectModel
      attribute :name
      attribute :target_number, :type => DataType::Integer
      reference :character, "AresMUSH::Character"
      index :name
      
    
    
      end

    


   class TorVirtues < Ohm::Model
        include ObjectModel
        
        attribute :name
        attribute :desc
        reference :character, "AresMUSH::Character"
        index :name
        
    end



    #class TorRewards < Ohm::Model
     #   include ObjectModel
        
      #  attribute :name
       # attribute :desc
        #reference :character, "AresMUSH::Character"
     #   index :name
        
 #   end


  #  class TorDistinctiveFeatures < Ohm::Model
   #     include ObjectModel
        
    #    attribute :name
     #   attribute :desc
      #  reference :character, "AresMUSH::Character"
       # index :name
        
   # end




    class TorArmour < Ohm::Model
        include ObjectModel
        attribute :name
        attribute :desc
        attribute :rewards
        attribute :equipped
        attribute :type
        attribute :origin
        attribute :custom_name
        attribute :protection, :type => DataType::Integer
        attribute :gearload, :type => DataType::Integer
        reference :character, "AresMUSH::Character"
        index :name       
    end


    class TorWeapons < Ohm::Model
        include ObjectModel
        
        attribute :name
        attribute :desc
        attribute :rewards
        attribute :proficiency
        attribute :equipped
        attribute :wielded
        attribute :origin
        attribute :custom_name
        attribute :hands
        attribute :bane1
        attribute :bane2
        attribute :damage, :type => DataType::Integer
        attribute :injury, :type => DataType::Integer
        attribute :gearload, :type => DataType::Integer
        reference :character, "AresMUSH::Character"
        index :name
        
    end


    class TorShields < Ohm::Model
        include ObjectModel
        
        attribute :name
        attribute :desc
        attribute :rewards
        attribute :equipped
        attribute :wielded
        attribute :origin
        attribute :custom_name
        attribute :parrymodifier, :type => DataType::Integer
        attribute :gearload, :type => DataType::Integer
        reference :character, "AresMUSH::Character"
        index :name
                
    end


end