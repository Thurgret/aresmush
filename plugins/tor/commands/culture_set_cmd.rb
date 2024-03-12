module AresMUSH    
    module Tor
      class CultureSetCmd
        include CommandHandler
        
        attr_accessor :target_name, :culture_name
        
        def parse_args
          # Admin version
          
          if (cmd.args =~ /\//)
            args = cmd.parse_args(ArgParser.arg1_slash_arg2)
            self.target_name = titlecase_arg(args.arg1)
            self.culture_name = titlecase_arg(args.arg2)
          else
            args = cmd.args
            self.target_name = enactor_name
            self.culture_name = titlecase_arg(args)
          end
        end
        
        def required_args
          [self.target_name, self.culture_name]
        end
        
        def check_valid_culture
          return t('tor.invalid_culture_name') if !Tor.is_valid_culture_name?(self.culture_name)
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
            culture = Tor.find_culture(model, self.culture_name)
                       
            if (culture)
                client.emit_success("Trying this out")
              culture.update(name: self.culture)
            else
                TorCulture.create(name: self.culture_name, character: model)
            end
           
            client.emit_success t('tor.culture_set')
        
        end
    end
  end
end
end