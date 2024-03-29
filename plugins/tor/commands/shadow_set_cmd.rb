module AresMUSH    
    module Tor
      class ShadowSetCmd
        include CommandHandler
        
        attr_accessor :target_name, :shadow, :shadow_scars
        
        def parse_args
          # Admin version
        
        
          if (cmd.args =~ /\//)
            args = cmd.parse_args(ArgParser.arg1_equals_arg2_slash_optional_arg3)
            self.target_name = titlecase_arg(args.arg1)
            self.shadow = integer_arg(args.arg2)
            self.shadow_scars = integer_arg(args.arg3)
          else
            args = cmd.parse_args(ArgParser.arg1_equals_arg2)
            self.target_name = titlecase_arg(args.arg1)
            self.shadow = integer_arg(args.arg2)
            self.shadow_scars = nil
          end
        
        end
        
        def required_args
          [self.target_name, self.shadow]
        end
        
                
        def check_can_set
          #return nil if enactor_name == self.target_name - this version is now admin only
          return nil if Tor.can_manage_abilities?(enactor)
          return t('dispatcher.not_allowed')
        end     
        
        def check_chargen_locked
          return nil if Tor.can_manage_abilities?(enactor)
          Chargen.check_chargen_locked(enactor)
        end
        
        
        def handle
          ClassTargetFinder.with_a_character(self.target_name, client, enactor) do |model|
            if (self.shadow_scars == nil)
              self.shadow_scars = model.tor_shadowscars
            end
                                  
            
              model.update(:tor_shadow => self.shadow)
              model.update(:tor_shadowscars => self.shadow_scars)
              new_total = shadow + shadow_scars
              model.update(:tor_shadowtotal => new_total)
            
           
            client.emit_success "Shadow set."
        
       
         
          end
    
        end
 
      end

    end
  end
  