module AresMUSH    
    module Tor
      class AttributesSelectCmd
        include CommandHandler
        
        attr_accessor :target_name, :options
        
        def parse_args
          # Admin version
          
          if (cmd.args =~ /=/)
            args = cmd.parse_args(ArgParser.arg1_equals_arg2)
            self.target_name = titlecase_arg(args.arg1)
            self.options = titlecase_arg(args.arg2).to_s
          else
            args = cmd.args
            self.target_name = enactor_name
            self.options = args.to_s
          end
        end
        
        def required_args
          [self.target_name, self.options]
        end
        
        def check_valid_attribute_options
          return t('tor.invalid_attribute_option') if !Tor.is_valid_attribute_options?(self.options)
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

            Tor.select_attributes(model, self.options)

            
            client.emit_success t('tor.attribute_set')
        
        end
    end
  end
end
end
  