module AresMUSH    
    module Tor
      class FavouredSkillsSetCmd
        include CommandHandler
        
        attr_accessor :target_name, :favoured_skills
        
        def parse_args
          # Admin version
          
            args = cmd.parse_args(ArgParser.arg1_equals_arg2)
            self.target_name = titlecase_arg(args.arg1)
            self.favoured_skills = titlecase_arg(args.arg2)
    
        end
        
        def required_args
          [self.target_name, self.favoured_skills]
        end
        
        
        def check_can_set
          return nil if Tor.can_manage_abilities?(enactor)
          return t('dispatcher.not_allowed')
        end     
        
        def handle
          ClassTargetFinder.with_a_character(self.target_name, client, enactor) do |model|
            model.update(:favoured_skills => favoured_skills)
            end
           
            client.emit_success "Favoured skills set."
        
        end
    end
  end
end
end
  