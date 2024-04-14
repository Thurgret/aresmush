module AresMUSH    
    module Tor
      class TreasureSetCmd
        include CommandHandler
        
        attr_accessor :target_name, :points
        
        def parse_args
          # Admin version
          
            args = cmd.parse_args(ArgParser.arg1_equals_arg2)
            self.target_name = titlecase_arg(args.arg1)
            self.points = args.arg2.to_i

        end
        
        def required_args
          [self.target_name, self.points]
        end
        
        
        def check_can_set
          return nil if Tor.can_manage_abilities?(enactor)
          return t('dispatcher.not_allowed')
        end     
        
        def check_chargen_locked
          return nil if Tor.can_manage_abilities?(enactor)
        end
        
        def handle
          ClassTargetFinder.with_a_character(self.target_name, client, enactor) do |model|
            model.update(:treasure => self.points)

        
         
          end
    
        end
  end
end
end
  