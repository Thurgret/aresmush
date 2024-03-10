module AresMUSH    
  module Tor
    class RollCmd
      include CommandHandler
      
      attr_accessor :roll_str, :modifier
  
      def parse_args
         return if !cmd.args
         self.roll_str = trim_arg(cmd.args.before("vs"))
         self.modifier = integer_arg(cmd.args.after("+"))
      end
      
      def required_args
        [ self.roll_str ]
      end
      
      def check_modifier
        return nil if self.modifier.blank?
        return t('tor.invalid_difficulty') if !modifier.is_a? Integer
        return nil
      end
      
      def handle
        results = Tor.roll_ability(enactor, self.roll_str)
        
        if (!results)
          client.emit_failure t('tor.invalid_skill')
          return
        end

        if (results.is_botch?)
          Rooms.emit_ooc_to_room enactor_room, t('cortex.roll_botch', :name => enactor_name, :roll_str => results.pretty_input, :dice => results.print_dice)
          return
        end
        
        message = Cortex.get_success_message(enactor_name, results, self.difficulty)
        Rooms.emit_ooc_to_room enactor_room, message               
      end
    end
  end
end
