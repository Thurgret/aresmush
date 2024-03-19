module AresMUSH    
    module Tor
      class WargearDiscardCmd
        include CommandHandler
        
        attr_accessor :target_name, :wargear_name
        
        def parse_args
          # Admin version
          
          if (cmd.args =~ /=/)
            args = cmd.parse_args(ArgParser.arg1_equals_arg2)
            self.target_name = titlecase_arg(args.arg1)
            self.wargear_name = titlecase_arg(args.arg2)
          else
            args = cmd.args
            self.target_name = enactor_name
            self.wargear_name = args.to_s
          end
        end
        
        def required_args
          [self.target_name, self.wargear_name]
        end
        
        def check_valid_rating
          return nil
        end
        
        def check_valid_armour
          return t('tor.invalid_armour_name') if ((!Tor.is_valid_armour_name?(self.wargear_name)) && (!Tor.is_valid_weapon_name?(self.wargear_name)) && (!Tor.is_valid_shield_name?(self.wargear_name)))
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
            if (Tor.is_valid_armour_name?(self.wargear_name))
              armour = Tor.find_armour(model, self.wargear_name)
              if (armour)
                 Tor.discard_armour(model, self.wargear_name)

                 message = enactor_name + " discards a " + wargear_name + "."
                Rooms.emit_ooc_to_room enactor_room, message
              else
                    client.emit_failure "You don't have that armour to discard."
            
                  
                  end
                end
                if (Tor.is_valid_weapon_name?(self.wargear_name))
                  weapon = Tor.find_weapon(model, self.wargear_name)
                  if (weapon)
                    Tor.discard_weapon(model, self.wargear_name)

                    message = enactor_name + " discards a " + wargear_name + "."
                Rooms.emit_ooc_to_room enactor_room, message
                  else
                  client.emit_failure "You don't have that weapon to discard."
                end
                end
                if (Tor.is_valid_shield_name?(self.wargear_name))
                  
                  shield = Tor.find_shield(model, self.wargear_name)
                
                  if (shield)
                    Tor.discard_shield(model, self.wargear_name)

                    message = enactor_name + " discards a " + wargear_name + "."
                    Rooms.emit_ooc_to_room enactor_room, message                  else
                    client.emit_failure "You don't have that shield to discard."
                  end
                end

        end
    end
  end
end
end
  