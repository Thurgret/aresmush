module AresMUSH    
    module Tor
      class TNSetCmd
        include CommandHandler
        
        attr_accessor :target_name, :attribute_name, :rating
        
        def parse_args
          # Admin version
          
          if (cmd.args =~ /\//)
            args = cmd.parse_args(ArgParser.arg1_equals_arg2_slash_arg3)
            self.target_name = titlecase_arg(args.arg1)
            self.attribute_name = titlecase_arg(args.arg2)
            self.rating = integer_arg(args.arg3)
          else
            args = cmd.parse_args(ArgParser.arg1_equals_arg2)
            self.target_name = enactor_name
            self.attribute_name = titlecase_arg(args.arg1)
            self.rating = integer_arg(args.arg2)
          end
        end
        
        def required_args
          [self.target_name, self.attribute_name, self.rating]
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
            tn = Tor.find_tn(model, self.attribute_name)
                       
            if (tn)
              tn.update(:target_number => self.rating)
            else
               TorTN.create(:name => self.attribute_name, :target_number => self.rating, :character => model)
            end
           
            client.emit_success t('tor.attribute_set')
        
        end
    end
  end
end
end
  