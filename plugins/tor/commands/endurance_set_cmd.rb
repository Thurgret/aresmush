module AresMUSH    
    module Tor
      class EnduranceSetCmd
        include CommandHandler
        
        attr_accessor :target_name, :rating, :maxendurance_rating
        
        def parse_args
          # Admin version
        
        
          if (cmd.args =~ /\//)
            args = cmd.parse_args(ArgParser.arg1_equals_arg2_slash_optional_arg3)
            self.target_name = titlecase_arg(args.arg1)
            self.rating = integer_arg(args.arg2)
            self.maxendurance_rating = integer_arg(args.arg3)
          else
            args = cmd.parse_args(ArgParser.arg1_equals_arg2)
            self.target_name = titlecase_arg(args.arg1)
            self.rating = integer_arg(args.arg2)
            self.maxendurance_rating = nil
          end
        
        end
        
        def required_args
          [self.target_name, self.rating]
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
            if (self.maxendurance_rating == nil)
              self.maxendurance_rating = model.tor_maxendurance
            end
                                  
            if (model.tor_endurance)
              model.update(:tor_endurance => self.rating)
              model.update(:tor_maxendurance => self.maxendurance_rating)
            else
                model.create(:tor_maxendurance => self.maxendurance_rating)
                model.create(:tor_endurance => self.rating)
            end
           
            client.emit_success "Endurance set."
        
       
         
          end
    
        end
 
      end

    end
  end
  