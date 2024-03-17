module AresMUSH    
    module Tor
      class VirtueSetCmd
        include CommandHandler
        
        attr_accessor :target_name, :firstproficiency, :secondproficiency
        
        def parse_args
          # Admin version
          if (cmd.args =~ /=/)
            args = cmd.parse_args(ArgParser.arg1_equals_arg2_slash_arg3)
            self.target_name = titlecase_arg(args.arg1)
            self.firstproficiency = titlecase_arg(args.arg2)
            self.secondproficiency = titlecase_arg(args.arg3)
          else
            args = cmd.parse_args(ArgParser.arg1_slash_arg2)
            self.target_name = enactor_name
            self.firstproficiency = titlecase_arg(args.arg1)
            self.secondproficiency = titlecase_arg(args.arg2)
          end
        end
        
        def required_args
            [self.firstproficiency, self.secondproficiency]
        end
        
        def check_valid_proficiency
            if !["Axes", "Bows", "Spears", "Swords"].include? self.firstproficiency || !["Axes", "Bows", "Spears", "Swords"].include? self.secondproficiency
                return t('tor.invalid_combat_proficiency')
            return nil
        end
        
        def check_can_set
          ClassTargetFinder.with_a_character(self.target_name, client, enactor) do |model|
            proficiency_config = Tor.find_combat_proficiencies_config(model)
            if (!proficiency_config.include? self.firstproficiency)
                   return t('tor.proficiency_not_available')
            end
               
          return nil if enactor_name == self.target_name
          return nil if Tor.can_manage_abilities?(enactor)
          return t('dispatcher.not_allowed')
          end
        end     
        
        def check_chargen_locked
          return nil if Tor.can_manage_abilities?(enactor)
          Chargen.check_chargen_locked(enactor)
        end
        
        def handle
          ClassTargetFinder.with_a_character(self.target_name, client, enactor) do |model|


            Tor.set_combat_proficiency(model, firstproficiency, 2)
            Tor.set_combat_proficiency(model, secondproficiency, 2)
            
            client.emit_success t('tor.virtue_set')
            end
         
          end
        end
      end
    end
  end
  