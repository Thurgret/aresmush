module AresMUSH
    module Tor
        class TorRollParams
            attr_accessor :modifier, :skill

            def initialize
                self.modifier = 0
                self.skill = nil
            end
        end



        class TorRollResults
            attr_accessor :successful, :eye_of_mordor, :gandalf_rune, :degrees, :dice, :feat_die, :target_number

            def initialize
                dice = []
            end

        end


        #def self.parse_roll_string(roll_str)
         #   params = TorRollParams.new
            #sections = roll_str.split(/([\+-]\d+\w)/)
            #sections.each do |s|
             #   s = s.strip.titlecase.gsub("+", "")
              #  next if s.blank?
               # if (s =~ /([-\d]+)/i)
                #    params.modifier = $1.to_i
                #else
                 #   config = Tor.find_skill_config(s)
                  #  return nil if !config
                   # params.skill = s
                #end
            #end


          #  return params  
        #end


            
           
        def self.roll_skill(char, skill_name, modifier)
            #params = Tor.parse_roll_string(roll_str)


            return nil if !skill_name

            if !modifier
                modifier = 0
            end

            dice = []
            skill_dice = Tor.find_skill_dice(char, skill_name) + modifier

            results = TorRollResults.new


            skill_dice.times.each do |d|
                dice << Tor.roll_success_die
            end
            results.dice = dice
            feat_die = Tor.roll_feat_die

            target_number = 20 - related_attribute_rating(char, skill_name)
            current_number = 0
            degrees = 0



            dice.each do |result|
                current_number += result
                if result == 6
                    degrees += 1
                end
            end

       
            results.target_number = target_number

            if feat_die == 'Eye'
                results.eye_of_mordor = true
            elsif feat_die == 'Rune'
                results.successful = true
                results.gandalf_rune = true
                message = t('tor.gandalf_rune')
            else
                current_number += feat_die
                results.feat_die = feat_die
            end

            if current_number >= target_number
                results.successful = true
            else
                results.successful = false
            end 

            results.degrees = degrees

            return results


               
        end


        def self.find_skill_dice(char, skill)
            skill_rating = Tor.skill_rating(char, skill)
        end


        def self.related_attribute_rating(char, skill)
            skill_config = Tor.find_skill_config(skill)
            return 0 if !skill_config
            Tor.attribute_rating(char, skill_config['linked_attribute'])
        end


        def self.roll_feat_die
            [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 'Eye', 'Rune' ].shuffle.first
        end


        def self.roll_success_die
            [ 1, 2, 3, 4, 5, 6 ].shuffle.first
        end



    
   
    end
end

  