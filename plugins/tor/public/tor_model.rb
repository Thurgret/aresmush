module AresMUSH
    class Character < Ohm::Model
    
        
    
    
        attribute :tor_culture     
        attribute :tor_calling
        
        
        collection :tor_attributes, "AresMUSH::TorAttributes"
        collection :tor_skills, "AresMUSH::TorSkill"
        collection :tor_tn, "AresMUSH::TorTN"
        collection :tor_virtues, "AresMUSH::TorVirtues"
        collection :tor_rewards, "AresMUSH::TorRewards"
        collection :tor_distinctivefeatures, "AresMUSH::TorDistinctiveFeatures"
        collection :tor_combatproficiencies, "AresMUSH::TorCombatProficiencies"
        collection :tor_armour, "AresMUSH::TorArmour"
        collection :tor_weapons, "AresMUSH::TorWeapons"
        collection :tor_shields, "AresMUSH::TorShields"
        
        attribute :tor_adventure_points, :type => DataType::Integer
        attribute :tor_skill_points, :type => DataType::Integer
        
        attribute :tor_wisdom, :type => DataType::Integer
        attribute :tor_valour, :type => DataType::Integer
        
        attribute :tor_maxhope, :type => DataType::Integer
        attribute :tor_hope, :type => DataType::Integer
        
        attribute :tor_shadow, :type => DataType::Integer
        attribute :tor_shadowscars, :type => DataType::Integer
        
        attribute :tor_maxendurance, :type => DataType::Integer
        attribute :tor_endurance, :type => DataType::Integer
        
        attribute :tor_parry, :type => DataType::Integer
        
        attribute :treasure, :type => DataType::Integer
  
  
        before_delete :delete_tor_abilities
      
      def delete_tor_abilities
        [ self.tor_distinctivefeatures, self.tor_skills, self.tor_attributes, self.tor_tn, self.tor_combatproficiencies,
          self.tor_virtues, self.tor_rewards, self.tor_armour, self.tor_weapons, self.tor_shields ].each do |list|
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
        attribute :rating :type => DataType::Integer
        reference :character, "AresMUSH::Character"
        index :name
        
    end



    class TorSkills < Ohm::Model
        include ObjectModel
        
        attribute :name
        attribute :desc
        attribute :rating :type => DataType::Integer
        reference :character, "AresMUSH::Character"
        index :name
        
    end



    class TorTN < Ohm::Model
        include ObjectModel
        
        attribute :name
        attribute :desc
        attribute :targetnumber :type => DataType::Integer
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



    class TorRewards < Ohm::Model
        include ObjectModel
        
        attribute :name
        attribute :desc
        reference :character, "AresMUSH::Character"
        index :name
        
    end


    class TorDistinctiveFeatures < Ohm::Model
        include ObjectModel
        
        attribute :name
        attribute :desc
        reference :character, "AresMUSH::Character"
        index :name
        
    end


    class TorCombatProficiencies < Ohm::Model
        include ObjectModel
        
        attribute :name
        attribute :desc
        reference :character, "AresMUSH::Character"
        index :name
        
    end



    class TorArmour < Ohm::Model
        include ObjectModel
        
        attribute :name
        attribute :desc
        attribute :protection :type => DataType::Integer
        attribute :load :type => DataType::Integer
        reference :character, "AresMUSH::Character"
        index :name
        
    end


    class TorWeapons < Ohm::Model
        include ObjectModel
        
        attribute :name
        attribute :desc
        attribute :proficiency
        attribute :damage :type => DataType::Integer
        attribute :injury :type => DataType::Integer
        attribute :load :type => DataType::Integer
        reference :character, "AresMUSH::Character"
        index :name
        
    end


    class TorShields < Ohm::Model
        include ObjectModel
        
        attribute :name
        attribute :desc
        attribute :parrymodifier :type => DataType::Integer
        attribute :load :type => DataType::Integer
        reference :character, "AresMUSH::Character"
        index :name
                
    end


end