module AresMUSH    
  module Tor
    class RollCmd
      include CommandHandler
      
      attr_accessor :roll_str, :modifier
  
      def parse_args
         return if !cmd.args
         self.roll_str = trim_arg(cmd.args)
      #   self.modifier = trim_arg(cmd.args.after("+")).to_i
      end
      
      def required_args
        [ self.roll_str ]
      end
      
      #def check_modifier
       # return nil if self.modifier.blank?
        #return t('tor.invalid_difficulty') if (modifier == 0)
       # return nil
      #end
      
      def handle
        results = Tor.roll_skill(enactor, self.roll_str)
        
        if (!results)
          client.emit_failure t('tor.invalid_skill')
          return
        end


      
      
     
        if (results.successful == true)
          if (results.gandalf_rune)
            message = t('tor.gandalf_rune', :dice => results.dice(' '), :roll => self.roll_str, :char => enactor_name )
          elsif (results.eye_of_mordor)
            message = t('tor.roll_eye_of_mordor_success', :dice => results.dice(' '), :roll => self.roll_str, :char => enactor_name )
          else
            message = t('tor.roll_successful', :dice => results.dice(' '),  :feat_die => results.feat_die(' '), :roll => self.roll_str, :char => enactor_name )
          end
        end
          
        if (results.successful == false)
            if (results.eye_of_mordor)
              message = t('tor.eye_of_mordor_failure', :dice => results.dice(' '), :roll => self.roll_str, :char => enactor_name )
            else
              message = t('tor.roll_failure', :dice => results.dice(' '), :feat_die => results.feat_die(' '),  :roll => self.roll_str, :char => enactor_name )
            end
          end
        end

       
      
        Rooms.emit_ooc_to_room enactor_room, message          
                
      end
    end
  end
end
