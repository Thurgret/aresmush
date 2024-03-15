module AresMUSH    
    module Tor
      class HopeSetCmd
        include CommandHandler
        
        attr_accessor :target_name, :rating
        
        def parse_args
          # Admin version
          args = cmd.parse_args(ArgParser.arg1_equals_arg2)
          self.target_name = arg1
          self.rating = integer_arg(args.arg2)
          end
        end
        
        def required_args
          [self.target_name, self.rating]
        end
        
        def check_valid_rating
          return nil
        end
        
        def check_valid_attribute
          return t('tor.invalid_attribute_name') if !Tor.is_valid_attribute_name?(self.attribute_name)
          return nil
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
            hope = target_name.tor_hope
                       
            if (hope)
              hope.update(rating: self.rating)
            else
                model.create(:tor_maxhope => rating)
                model.create(:tor_hope => rating)
            end
           
            client.emit_success "Hope set."
        
       
          end
    
        end
 
      end

    end

  