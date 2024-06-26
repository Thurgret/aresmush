module AresMUSH    
    module Tor
      class CombatProficiencySetCmd
        include CommandHandler
        
        attr_accessor :target_name, :proficiency, :value
        
        def parse_args
          # Admin version
        
            args = cmd.parse_args(ArgParser.arg1_equals_arg2_slash_arg3)
            self.target_name = titlecase_arg(args.arg1)
            self.proficiency = titlecase_arg(args.arg2)
            self.value = titlecase_arg(args.arg3)
          
        end
        
        def required_args
            [self.proficiency, self.value]
        end
        
       
        
        def check_can_set
          
          return nil if Tor.can_manage_abilities?(enactor)
          return t('dispatcher.not_allowed')
          
        
        end
       
        
        def check_chargen_locked
          return nil if Tor.can_manage_abilities?(enactor)       
        end
        
        def handle



            options = ["Axes", "Bows", "Spears", "Swords"]
            onevalid = options.include?(self.proficiency)

            
            if (onevalid)



           
                ClassTargetFinder.with_a_character(self.target_name, client, enactor) do |model|

                    Tor.set_combat_proficiency(model, self.proficiency, self.value)              
                    client.emit_success "Combat proficiencies set."  
                end
            else
                client.emit_failure "Invalid skill names."
            
            end
        
            
      
        end
          
        
       
    
    end
         
         
   
    

end
       

end