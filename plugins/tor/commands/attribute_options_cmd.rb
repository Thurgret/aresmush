module AresMUSH    
    module Tor
      class AttributeOptionsCmd
        
        include CommandHandler
        
        attr_accessor :target_name
        
       
        def parse_args
          # Admin version          
          if (cmd.args)
            args = cmd.args
            self.target_name = titlecase_arg(args)
          else
            self.target_name = enactor_name
          end
        end
        
        def required_args
          [self.target_name]
        end

        
        def check_can_set
          return nil if enactor_name == self.target_name
          return nil if Tor.can_manage_abilities?(enactor)
          return t('dispatcher.not_allowed')
        end     
        
        def check_chargen_locked
          return nil if Tor.can_manage_abilities?(enactor)
          Chargen.check_chargen_locked(enactor)
        end
        
        def handle
          ClassTargetFinder.with_a_character(self.target_name, client, enactor) do |model|
            culture_name = model.group("Culture")

            if culture_name == nil
              client.emit_failure t('tor.invalid_culture')
              return nil          
            end

            
            


            options = Tor.attribute_options(culture_name)

            options.each do |number, attrs, rating|
                Global.logger.debug culture_name
                Global.logger.debug number
                Global.logger.debug attrs
                client.emit_success t('tor.attribute_option', :option => number, :attrs => attrs, :rating => rating)
            end
        end       
        end
    end


  end


end