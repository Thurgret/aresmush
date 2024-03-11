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


        if results.successful  
          message = t('roll.successful')
        else
          message = t('roll.failure')
      end


        Rooms.emit_ooc_to_room enactor_room, message          
                
      end
    end
  end
end
