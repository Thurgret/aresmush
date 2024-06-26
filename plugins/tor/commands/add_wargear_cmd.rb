module AresMUSH    
    module Tor
      class WargearAddCmd
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
                    client.emit_failure "You already have that type of armour."
                    return nil
                else
                  client.emit_success "Armour added."
                    Tor.add_armour(model, self.wargear_name)
                end
            end
            if (Tor.is_valid_weapon_name?(self.wargear_name))
              weapon = Tor.find_weapon(model, self.wargear_name)
              if (weapon)
                client.emit_failure "You already have that type of weapon"
                return nil
              else
                client.emit_success "Weapon added."
              Tor.add_weapon(model, self.wargear_name)
              end
            end
            if (Tor.is_valid_shield_name?(self.wargear_name))
              shield = Tor.find_shield(model, self.wargear_name)
              if (shield)
                client.emit_failure "You already have that type of shield."
              else
                client.emit_success "Shield added."
                Tor.add_shield(model, self.wargear_name)
              end
            end


        
          end
    end
  end
end
end
  