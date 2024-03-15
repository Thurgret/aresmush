module AresMUSH    
    module Tor
      class CultureSetCmd
        
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
            culture = Tor.find_culture(model, culture_name)
                if (culture)
                    culture.update(name: culture_name)
                else
                    TorCulture.create(name: culture_name, character: model)
                end
                
                Tor.culture_skills(model, culture_name)
                Tor.select_attributes(model, 5)
                Tor.set_valour(model, 1)
                Tor.set_wisdom(model, 1)
           
                client.emit_success t('tor.culture_set')
       
            
              end
            end
          end

        end

end