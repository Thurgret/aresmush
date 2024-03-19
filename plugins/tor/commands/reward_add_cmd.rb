module AresMUSH    
    module Tor
      class RewardAddCmd
        include CommandHandler
        
        attr_accessor :target_name, :wargear_name, :reward_name
        
        def parse_args
          # Admin version
          
          if (cmd.args =~ /=/)
            args = cmd.parse_args(ArgParser.arg1_equals_arg2_slash_arg3)
            self.target_name = titlecase_arg(args.arg1)
            self.wargear_name = titlecase_arg(args.arg2)
            self.reward_name = titlecase_arg(args.arg3)

          else
            args = cmd.parse_args(ArgParser.arg1_slash_arg2)
            self.target_name = enactor_name
            self.wargear_name = titlecase_arg(args.arg1)
            self.reward_name = titlecase_arg(args.arg2)
          end
        end
        
        def required_args
          [self.target_name, self.wargear_name, self.reward_name]
        end
        
        def check_valid_rating
          return nil
        end
        
        def check_valid_wargear
        #  return t('tor.invalid_armour_name') if ((!Tor.is_valid_armour_name?(self.wargear_name)) && (!Tor.is_valid_weapon_name?(self.wargear_name)) && (!Tor.is_valid_shield_name?(self.wargear_name)))
          return nil
        end
        
        def check_can_set
          return nil if enactor_name == self.target_name
          return nil if Tor.can_manage_abilities?(enactor)
          return t('dispatcher.not_allowed')
        end     
        
        def check_chargen_locked
          return nil if Tor.can_manage_abilities?(enactor)
          Chargen.check_chargen_locked(enactor)
        end
        
        def handle
          ClassTargetFinder.with_a_character(self.target_name, client, enactor) do |model|
            Tor.add_weapon_reward(model, self.wargear_name, self.reward_name)
          end
        end
            
           
           
        
        end


        
         
        
    end
  
end