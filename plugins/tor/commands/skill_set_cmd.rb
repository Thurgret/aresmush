module AresMUSH    
    module Tor
      class SkillSetCmd
        include CommandHandler
        
        attr_accessor :target_name, :skill_name, :rating
        
        def parse_args
          # Admin version
          if (cmd.args =~ /\//)
            args = cmd.parse_args(ArgParser.arg1_equals_arg2_slash_arg3)
            self.target_name = titlecase_arg(args.arg1)
            self.skill_name = titlecase_arg(args.arg2)
            self.rating = integer_arg(args.arg3)
          else
            args = cmd.parse_args(ArgParser.arg1_equals_arg2)
            self.target_name = enactor_name
            self.skill_name = titlecase_arg(args.arg1)
            self.rating = integer_arg(args.arg2)
          end
        end
        
        def required_args
          [self.target_name, self.skill_name, self.rating]
        end
        
        def check_valid_rating
          return t('tor.invalid_rating') if !Tor.is_valid_rating?(self.rating)
          return nil
        end
        
        def check_valid_skill
          return t('tor.invalid_skill_name') if !Tor.is_valid_skill_name?(self.skill_name)
          return nil
        end
        
        def check_can_set
          ##return nil if enactor_name == self.target_name - now admin only
          return nil if Tor.can_manage_abilities?(enactor)
          return t('dispatcher.not_allowed')
        end     
        
        def check_chargen_locked
          return nil if Tor.can_manage_abilities?(enactor)
          Chargen.check_chargen_locked(enactor)
        end
        
        def handle
          ClassTargetFinder.with_a_character(self.target_name, client, enactor) do |model|
            skill = Tor.find_skill(model, self.skill_name)
                       
            if (skill)
              skill.update(rating: self.rating)
            else
              TorSkills.create(name: self.skill_name, rating: self.rating, character: model)
            end
           
            client.emit_success t('tor.skill_set')
         
          end
        end
      end
    end
  end
  