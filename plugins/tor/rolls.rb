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
            attr_accessor :successful, :eye_of_mordor, :gandalf_rune, :degrees, :dice, :feat_dice, :target_number, :total_number, :weary, :miserable

            def initialize
                dice = []
                feat_dice = []
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


            
           
        def self.roll_skill(char, skill_name, modifier, favoured, alternative_tn, weary, miserable)
            #params = Tor.parse_roll_string(roll_str)


            return nil if !skill_name

            return nil if (!Tor.find_skill(char, skill_name) && skill_name.downcase != "valour" && skill_name.downcase != "wisdom" && skill_name.downcase != "axes" && skill_name.downcase != "bows" && skill_name.downcase != "spears" && skill_name.downcase != "swords" && skill_name.downcase != "protection")

            if !modifier
                modifier = 0
            end

            if (favoured.downcase == "n")
                favoured = nil
            end
            

            


            dice = []
            feat_dice = []
            if (Tor.find_skill(char, skill_name))
                skill_dice = Tor.find_skill_dice(char, skill_name) + modifier
                related_attribute = Tor.find_related_attribute_name(skill_name)
                target_number = tn_rating(char, related_attribute)        
            elsif (skill_name.downcase == "wisdom")
                skill_dice = char.tor_wisdom.to_i + modifier
                target_number = tn_rating(char, "Wits")        
            elsif (skill_name.downcase == "valour")
                skill_dice = char.tor_valour.to_i + modifier
                target_number = tn_rating(char, "Heart")
            elsif (skill_name.downcase == "axes")
                skill_dice = char.tor_axes_proficiency.to_i + modifier
                target_number = tn_rating(char, "Strength")
            elsif (skill_name.downcase == "bows")
                skill_dice = char.tor_bows_proficiency.to_i + modifier
                target_number = tn_rating(char, "Strength")
            elsif (skill_name.downcase == "spears")
                skill_dice = char.tor_spears_proficiency.to_i + modifier
                target_number = tn_rating(char, "Strength")
            elsif (skill_name.downcase == "swords")
                skill_dice = char.tor_swords_proficiency.to_i + modifier
                target_number = tn_rating(char, "Strength")
            elsif (skill_name.downcase == "protection")
                skill_dice = char.tor_protection.to_i + modifier
                target_number = alternative_tn
            end

            results = TorRollResults.new

            if (weary == "weary")
                results.weary = true
            end
            if (miserable == "miserable")
                results.miserable = true
            end


            skill_dice.times.each do |d|
                dice << Tor.roll_success_die
            end
            results.dice = dice.sort.reverse

            if !favoured
                feat_dice[0] = Tor.roll_feat_die
                results.feat_dice = feat_dice
            elsif (favoured == "F")
                feat_dice[0] = Tor.roll_feat_die
                feat_dice[1] = Tor.roll_feat_die
                if feat_dice[0] < feat_dice[1]
                    feat_dice = feat_dice.reverse
                end
            elsif (favoured == "I")   
                feat_dice[0] = Tor.roll_feat_die
                    feat_dice[1] = Tor.roll_feat_die
                if feat_dice[0] > feat_dice[1]
                    feat_dice = feat_dice.reverse
                end

            end

            results.feat_dice = feat_dice



                
            current_number = 0
            degrees = 0

            Global.logger.debug weary


            dice.each do |result|
                if (weary == "weary")
                    if (result >= 4)
                        current_number += result
                        
                Global.logger.debug result
                Global.logger.debug current_number
                    end
                else
                    current_number += result
                    
                Global.logger.debug result
                Global.logger.debug current_number
                end
                if result == 6
                    degrees += 1
                end
            end

            if (alternative_tn > 0)
                target_number = alternative_tn
                results.target_number = alternative_tn
            end

       
            results.target_number = target_number
            results.successful = false

            if feat_dice.first == 0
                results.eye_of_mordor = true
            elsif feat_dice.first == 11
                results.successful = true
                results.gandalf_rune = true
            else
                current_number += feat_dice.first
                results.feat_dice = feat_dice
            end

            if current_number >= target_number
                results.successful = true
            end 

            results.degrees = degrees

           
            return results


               
        end


        def self.find_skill_dice(char, skill)
            skill_rating = Tor.skill_rating(char, skill)
        end


        


        
        def self.roll_feat_die
            [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ].shuffle.first
        end


        def self.roll_success_die
            [ 1, 2, 3, 4, 5, 6 ].shuffle.first
        end



        def self.determine_web_roll_result(request, enactor)
      
            roll_str = request.args[:roll_string]
            pc_name = request.args[:pc_name] || ""
            pc_skill = request.args[:pc_skill] || ""
            favoured = request.args[:favoured_string]
            rollmodifier = request.args[:modifier_string].to_i
            alternative_tn = request.args[:alternative_tn_string].to_i
            weary = request.args[:weary_string]
            miserable = request.args[:miserable_string]

            if (weary.length > 0)
                weary = "weary"
            end
            if (miserable.length > 0)
                miserable = "miserable"
            end
          

            

            skill_name = roll_str.titlecase
      
            # ------------------
            # PC ROLL
            # ------------------
           
            if (!pc_name.blank?)
              char = Character.find_one_by_name(pc_name)
      
              if (!char && !pc_skill.is_integer?)
                pc_skill = "3"
              end

              pc_name = char.name


              results = roll_skill(char, skill_name, rollmodifier, favoured, alternative_tn, weary, miserable)
      

              if (results.successful == true)
                if (results.gandalf_rune)
                  message = t('tor.gandalf_rune', :dice => results.dice.join(" "), :feat_dice => results.feat_dice.join(" "),
                   :roll => skill_name, :char => pc_name, :TN => results.target_number.to_s )
                elsif (results.eye_of_mordor)
                  message = t('tor.roll_eye_of_mordor_success', :dice => results.dice.join(" "), :feat_dice => results.feat_dice.join(" "),
                   :roll => skill_name, :char => pc_name, :TN => results.target_number.to_s )
                else
                  message = t('tor.roll_successful', :dice => results.dice.join(" "), :feat_dice => results.feat_dice.join(" "), :roll => skill_name, 
                  :char => pc_name, :TN => results.target_number.to_s )
                end
              end
                
             
             
              if (results.successful == false)
                  if (results.eye_of_mordor)
                    message = t('tor.eye_of_mordor_failure', :dice => results.dice.join(" "), :feat_dice => results.feat_dice.join(" "), 
                    :roll => skill_name, :char => pc_name, :TN => results.target_number.to_s )
                  else
                    message = t('tor.roll_failure', :dice => results.dice.join(" "), :feat_dice => results.feat_dice.join(" "),  :roll => skill_name, :char => pc_name,
                    :TN => results.target_number.to_s )
                  end
                
              
               
                
                end

            # ------------------
            # SELF ROLL
            # ------------------
            


            
        else


            

           
                results = roll_skill(enactor, skill_name, rollmodifier, favoured, alternative_tn, weary, miserable)


            pc_name = enactor.name



         
            if (results.successful == true)
                if (results.gandalf_rune)
                    message = t('tor.gandalf_rune', :dice => results.dice.join(" "), :feat_dice => results.feat_dice.join(" "),
                    :roll => skill_name, :char => pc_name, :TN => results.target_number.to_s )
                elsif (results.eye_of_mordor)
                    if (results.miserable == true)
                        message = t('tor.miserable_failure', :dice => results.dice.join(" "), :feat_dice => results.feat_dice.join(" "),
                        :roll => skill_name, :char => pc_name, :TN => results.target_number.to_s )
                    else
                        message = t('tor.roll_eye_of_mordor_success', :dice => results.dice.join(" "), :feat_dice => results.feat_dice.join(" "),
                        :roll => skill_name, :char => pc_name, :TN => results.target_number.to_s )
                    end
                else
                    message = t('tor.roll_successful', :dice => results.dice.join(" "), :feat_dice => results.feat_dice.join(" "), :roll => skill_name, 
                    :char => pc_name, :TN => results.target_number.to_s )       
                end
          
            end
                
             
             
              if (results.successful == false)
                  if (results.eye_of_mordor)
                    if (results.miserable == true)
                        message = t('tor.miserable_failure', :dice => results.dice.join(" "), :feat_dice => results.feat_dice.join(" "),
                        :roll => skill_name, :char => pc_name, :TN => results.target_number.to_s )
                    else
                    message = t('tor.eye_of_mordor_failure', :dice => results.dice.join(" "), :feat_dice => results.feat_dice.join(" "), 
                    :roll => skill_name, :char => pc_name, :TN => results.target_number.to_s )
                    end
                  else
                    message = t('tor.roll_failure', :dice => results.dice.join(" "), :feat_dice => results.feat_dice.join(" "),  :roll => skill_name, :char => pc_name,
                    :TN => results.target_number.to_s )
                  end
                end
            end
            
            return { message: message }
          end



          def self.emit_results(message, client, room, is_private)
            if (is_private)
              client.emit message
            else
              room.emit message
              channel = Global.read_config("fs3skills", "roll_channel")
              if (channel)
                Channels.send_to_channel(channel, message)
              end
              
              if (room.scene)
                Scenes.add_to_scene(room.scene, message)
              end
              
            end
            Global.logger.info "FS3 roll results: #{message}"
          end
  
   
    
    end

end

  