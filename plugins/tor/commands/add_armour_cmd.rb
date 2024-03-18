module AresMUSH    
    module Tor
      class ArmourAddCmd
        include CommandHandler
        
        attr_accessor :target_name, :armour_name
        
        def parse_args
          # Admin version
          
          if (cmd.args =~ /=/)
            args = cmd.parse_args(ArgParser.arg1_equals_arg2)
            self.target_name = titlecase_arg(args.arg1)
            self.armour_name = titlecase_arg(args.arg2)
          else
            args = cmd.args
            self.target_name = enactor_name
            self.armour_name = args.titlecase
          end
        end
        
        def required_args
          [self.target_name, self.armour_name]
        end
        
        def check_valid_rating
          return nil
        end
        
        def check_valid_attribute
          return t('tor.invalid_attribute_name') if !Tor.is_valid_armour_name?(self.attribute_name)
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
            armour = Tor.find_armour(model, self.armour_name)
                       
            if (armour)
              client.emit_failure "You already have that type of armour."
            else
               Tor.add_armour(model, self.armour_name)
            end
           
            client.emit_success t('tor.attribute_set')
        
        end
    end
  end
end
end
  