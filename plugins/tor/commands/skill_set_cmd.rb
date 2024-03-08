module AresMUSH    
    module Cortex
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
          return nil if self.rating == 0 || self.rating > 6
          return t('tor.invalid_rating') if !Cortex.is_valid_die_step?(self.die_step)
          return t('cortex.general_skill_step_limit') if ![ 'd2', 'd4', 'd6' ].include?(self.die_step)
          return nil
        end
        
        def check_valid_skill
          return t('cortex.invalid_skill_name') if !Cortex.is_valid_skill_name?(self.skill_name)
          return nil
        end
        
        def check_can_set
          return nil if enactor_name == self.target_name
          return nil if Cortex.can_manage_abilities?(enactor)
          return t('dispatcher.not_allowed')
        end     
        
        def check_chargen_locked
          return nil if Cortex.can_manage_abilities?(enactor)
          Chargen.check_chargen_locked(enactor)
        end
        
        def handle
          ClassTargetFinder.with_a_character(self.target_name, client, enactor) do |model|
            skill = Cortex.find_skill(model, self.skill_name)
            
            if (skill && self.die_step == '0')
              skill.delete
              client.emit_success t('cortex.ability_removed')
              return
            end
            
            if (skill)
              skill.update(die_step: self.die_step)
              if (self.die_step != 'd6')
                skill.update(specialties: {})
              end
            else
              CortexSkill.create(name: self.skill_name, die_step: self.die_step, character: model)
            end
           
            client.emit_success t('cortex.ability_set')
          end
        end
      end
    end
  end
  