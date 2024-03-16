module AresMUSH    
    module Tor
      class HopeSetCmd
        include CommandHandler
        
        attr_accessor :target_name, :rating, :maxhope_rating
        
        def parse_args
          # Admin version
        
        
          if (cmd.args =~ /\//)
            args = cmd.parse_args(ArgParser.arg1_equals_arg2_slash_optional_arg3)
            self.target_name = titlecase_arg(args.arg2)
            self.rating = integer_arg(args.arg2)
            self.maxhope_rating = integer_arg(args.arg3)
          else
            args = cmd.parse_args(ArgParser.arg1_equals_arg2)
            self.target_name = titlecase_arg(args.arg1)
            self.rating = integer_arg(args.arg2)
            self.maxhope_rating = nil
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
            if (maxhope_rating == nil)
              self.maxhope_rating = model.tor_maxhope
            end
                                  
            if (model.tor_hope)
              model.update(:tor_hope => self.rating)
              model.update(:tor_maxhope => self.maxhope_rating)
            else
                model.create(:tor_maxhope => self.rating)
                model.create(:tor_hope => self.rating)
            end
           
            client.emit_success "Hope set."
        
       
         
          end
    
        end
 
      end

    end
  end
  