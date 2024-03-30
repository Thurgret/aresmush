module AresMUSH    
    module Tor
      class LoadSetCmd
        include CommandHandler
        
        attr_accessor :target_name, :character_load
        
        def parse_args
          # Admin version
        
        
            args = cmd.parse_args(ArgParser.arg1_equals_arg2)
            self.target_name = titlecase_arg(args.arg1)
            self.character_load = integer_arg(args.arg2)
        
        end
        
        def required_args
          [self.target_name, self.character_load]
        end
        
                
        def check_can_set
          return nil if Tor.can_manage_abilities?(enactor)
          return t('dispatcher.not_allowed')
        end     
        
        def check_chargen_locked
          return nil if Tor.can_manage_abilities?(enactor)
          Chargen.check_chargen_locked(enactor)
        end
        
        
        def handle
          ClassTargetFinder.with_a_character(self.target_name, client, enactor) do |model|
            
            new_load = self.character_load
            model.update(:tor_load => new_load)
           
            client.emit_success "Load set."
        
       
         
    
        end
 
     
    end

   
end  