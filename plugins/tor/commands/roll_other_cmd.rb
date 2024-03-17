module AresMUSH    
    module Tor
      class RollOtherCmd
        include CommandHandler
        
        attr_accessor :roll_str, :modifier, :favoured, :character_name
    
        def parse_args
           return if !cmd.args
           firstargs = trim_arg(cmd.args.before("="))
           self.character_name = trim_arg(firstargs.before("/"))
           self.roll_str = trim_arg(firstargs.after("/"))
           secondargs = trim_arg(cmd.args.after("="))          
           self.modifier = integer_arg(secondargs.before("/"))
           self.favoured = titlecase_arg(secondargs.after("/"))
        end
        
        def required_args
          [ self.character_name, self.roll_str ]
        end
        
        def check_modifier
          return nil if self.modifier.blank?
          return nil
        end
  
        def check_favoured
          return nil if self.favoured.blank?
          return t('tor.invalid_favoured') if (favoured != "F" && favoured != "I")
          return nil
        end
        
        def handle

            ClassTargetFinder.with_a_character(self.character_name, client, enactor) do |model|
                results = Tor.roll_skill(model, self.roll_str, self.modifier, self.favoured)
          
          if (!results)
            client.emit_failure t('tor.invalid_skill')
            return
          end 
       
          if (results.successful == true)
            if (results.gandalf_rune)
              message = t('tor.gandalf_rune', :dice => results.dice.join(" "), :feat_dice => results.feat_dice.join(" "),
               :roll => self.roll_str, :char => character_name, :TN => results.target_number.to_s )
            elsif (results.eye_of_mordor)
              message = t('tor.roll_eye_of_mordor_success', :dice => results.dice.join(" "), :feat_dice => results.feat_dice.join(" "),
               :roll => self.roll_str, :char => character_name, :TN => results.target_number.to_s )
            else
              message = t('tor.roll_successful', :dice => results.dice.join(" "), :feat_dice => results.feat_dice.join(" "), :roll => self.roll_str, 
              :char => character_name, :TN => results.target_number.to_s )
            end
          end
            
         
          if (results.successful == false)
              if (results.eye_of_mordor)
                message = t('tor.eye_of_mordor_failure', :dice => results.dice.join(" "), :feat_dice => results.feat_dice.join(" "), 
                :roll => self.roll_str, :char => character_name, :TN => results.target_number.to_s )
              else
                message = t('tor.roll_failure', :dice => results.dice.join(" "), :feat_dice => results.feat_dice.join(" "),  :roll => self.roll_str, :char => character_name,
                :TN => results.target_number.to_s )
              end
            
           
            end
  
          Rooms.emit_ooc_to_room enactor_room, message          
                  
       
        end
        end
      end
    end
  end
  