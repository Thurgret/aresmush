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
            args = cmd.args.to_s
            self.target_name = enactor_name
            self.virtue_name = args
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
            virtue = Tor.find_virtue(model, self.virtue_name)
                       
            if (virtue)
              virtue.delete
            else
              TorVirtues.create(name: self.virtue_name, character: model)
            end
           
            client.emit_success t('tor.virtue_set')
         
          end
        end
      end
    end
  end
  