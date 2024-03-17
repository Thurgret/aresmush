module AresMUSH    
    module Tor
      class VirtueSetCmd
        include CommandHandler
        
        attr_accessor :target_name, :virtue_name
        
        def parse_args
          # Admin version
          if (cmd.args =~ /=/)
            args = cmd.parse_args(ArgParser.arg1_equals_arg2)
            self.target_name = titlecase_arg(args.arg1)
            self.virtue_name = titlecase_arg(args.arg2)
          else
            args = cmd.args
            self.target_name = enactor_name
            self.virtue_name = args.titlecase
          end
        end
        
        def required_args
          [self.target_name, self.virtue_name]
        end
        
        def check_valid_virtue
                return t('tor.invalid_virtue') if !Tor.is_valid_virtue_name?(self.virtue_name)
                return nil
            
        end
        
        def check_can_set
          ClassTargetFinder.with_a_character(self.target_name, client, enactor) do |model|
            virtue_config = Tor.find_virtue_config(self.virtue_name)
            virtue_culture = virtue_config["culture"]
            if (virtue_culture.downcase != "everyone" && !Tor.can_manage_abilities?(enactor))
                   return t('tor.invalid_virtue_not_for_everyone')
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
            if !Tor.virtue_set(model, self.virtue_name)
                client.emit_success "That virtue is not available to your culture."
            else    
           
                client.emit_success t('tor.virtue_set')
            end
         
          end
        end
      end
    end
  end
  