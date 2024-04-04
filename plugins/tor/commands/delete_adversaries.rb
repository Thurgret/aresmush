module AresMUSH    
    module Tor
      class DeleteAdversariesCmd
        include CommandHandler
        

        
        
        def check_can_set
          return nil if Tor.can_manage_abilities?(enactor)
          return t('dispatcher.not_allowed')
        end     
        
        
        def handle
          
            Adversary.all.each do |a|
                a.delete
            end
    
        end
  end
end
end
  