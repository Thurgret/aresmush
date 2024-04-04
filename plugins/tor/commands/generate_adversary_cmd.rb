module AresMUSH    
    module Tor
      class GenerateAdversaryCmd
        include CommandHandler
        
        attr_accessor :adversary_name, :adversary_type
        
        def parse_args
          # Admin version
          
          args = cmd.parse_args(ArgParser.arg1_equals_arg2)
          self.adversary_name = args.arg1
          self.adversary_type = args.arg2
        end
        
        def required_args
          [self.adversary_name]
        end
        
        
        
        def check_can_set
          return nil if Tor.can_manage_abilities?(enactor)
          return t('dispatcher.not_allowed')
        end     
        
        
        def handle
          
            Tor.generate_adversary(adversary_name, adversary_type)
    
        end
  end
end
end
  