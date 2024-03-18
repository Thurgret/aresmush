module AresMUSH    
    module Tor
      class StartingCombatProfienciesSetCmd
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




            options = ["Axes", "Bows", "Spears", "Swords"]
            onevalid = options.include?(self.firstproficiency)
            twovalid = options.include?(self.secondproficiency)

            
            if (onevalid && twovalid)



           
                ClassTargetFinder.with_a_character(self.target_name, client, enactor) do |model|
                    culture_name = model.group("Culture").downcase
                    proficiency_config = Tor.find_combat_proficiencies_config(culture_name)
                    option1 = proficiency_config['option1']
                    option2 = proficiency_config['option2']
                    
                    Tor.set_combat_proficiency(model, "Axes", 0)
                    Tor.set_combat_proficiency(model, "Bows", 0)
                    Tor.set_combat_proficiency(model, "Spears", 0)
                    Tor.set_combat_proficiency(model, "Swords", 0)
                
                
                    
                    if (!(option1 == self.firstproficiency) || !(option2 = self.firstproficiency))
                        client.emit_failure "Please select from one of the two options listed by the STARTINGCOMBATPROFICIENCES command."     
                        return nil             
                    end
           
               
                    if (self.firstproficiency == self.secondproficiency)
                        client.emit_failure "Please select a different proficiency for each option."  
                        return nil
                    end
                       
                            
                    Tor.set_combat_proficiency(model, self.firstproficiency, 2)              
                    Tor.set_combat_proficiency(model, self.secondproficiency, 1)                
                    client.emit_success "Combat proficiencies set."  
                end
            else
                client.emit_failure "Invalid skill names."
            
            end
        
            
      
        end
          
        
       
    
    end
         
         
   
    

end
       

end