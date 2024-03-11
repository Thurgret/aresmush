module AresMUSH    
  module Tor
    class RollCmd
      include CommandHandler
      
      attr_accessor :roll_str, :modifier
  
      def parse_args
         return if !cmd.args
         args = cmd.parse_args(ArgParser.arg1_equals_optional_arg2)
         self.roll_str = titlecase_arg(args.arg1)
         self.modifier = integer_arg(args.arg2)
      end
      
      def required_args
        [ self.roll_str ]
      end
      
      def check_modifier
        return nil if self.modifier.blank?
        return t('tor.invalid_difficulty') if (modifier == 0)
        return nil
      end
      
      def handle
        results = Tor.roll_skill(enactor, self.roll_str)
        
        if (!results)
          client.emit_failure t('tor.invalid_skill')
          return
        end 
     
        if (results.successful == true)
          if (results.gandalf_rune)
            message = t('tor.gandalf_rune', :dice => results.dice.join(" "), :roll => self.roll_str, :char => enactor_name )
          elsif (results.eye_of_mordor)
            message = t('tor.roll_eye_of_mordor_success', :dice => results.dice.join(" "), :roll => self.roll_str, :char => enactor_name )
          else
            message = t('tor.roll_successful', :dice => results.dice.join(" "), :feat_die => results.feat_die.to_s, :roll => self.roll_str, :char => enactor_name )
          end
        end
          
       
        if (results.successful == false)
            if (results.eye_of_mordor)
              message = t('tor.eye_of_mordor_failure', :dice => results.dice.join(" "), :roll => self.roll_str, :char => enactor_name )
            else
              message = t('tor.roll_failure', :dice => results.dice.join(" "), :feat_die => results.feat_die.to_s,  :roll => self.roll_str, :char => enactor_name )
            end
          
          end

        Rooms.emit_ooc_to_room enactor_room, message          
                
     
      end
    end
  end
end
