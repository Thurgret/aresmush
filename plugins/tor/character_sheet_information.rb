module AresMUSH
    module Tor
   
   


        def self.cultural_characteristics(char)
            culture = char.group("Culture").downcase
            if (culture == "bardings")
                return "Stout-hearted: Your VALOUR rolls are Favoured."
            elsif (culture == "bree-folk")
                return "Bree-blood: Each of the Bree-folk in the Company increases the Fellowship Rating by 1 point."
            elsif (culture == "dwarves of durin's folk")
                return "Redoubtable: You halve the Load rating of any armour you're wearing (rounding fractions up), including helms (but not shields).
                Naugrim: Dwarven adventurers cannot use the following pieces of war gear: great bow, great spear, and great shield."
            elsif (culture == "elves of lindon")
                return "Elven-skill: If you are not Miserable, you can spend 1 point of Hope to achieve a Magical success on a roll when using a Skill in which you possess at least one rank."    
            elsif (culture == "elves of rivendell")
                return "Elven-wise: Add 1 point to one Attribute of your choice. Additionally, if you are not Miserable, you can spend 1 point of Hope to achieve a Magical success on a skill roll.
                Beset by Woe: You can remove accumulated Shadow points exclusively during a Yule Fellowship Phase."
            elsif (culture == "hobbits of the shire")
                return "Hobbit-sense: Your WISDOM rolls are Favoured, and you gain (1d) on all Shadow Tests made to resist the effects of Greed.
                Halflings: Axe, bow, club, cudgel, dagger, short sword, short spear, spear. Additionally, Hobbits cannot use a great shield."    
            elsif (culture == "rangers of the north")
                return "Kings of Men: Add 1 point to one Attribute of your choice.
                Allegiance of the Dúnedain: During the Fellow ship phase (not Yule) you recover a maximum number of Hope points equal to half your HEART score (rounding fractions up)."
            end
        end


        def self.armour_list(char)
            list = char.tor_armour
            newlist = list.to_a.sort_by { |a| a.name }
            .each_with_index
              .map do |a, i|
                if a.equipped == "Equipped"
                  if a.rewards
                    if a.origin
                      "#{a.name}: Protection: #{a.protection} Load: #{a.gearload} Origin: #{a.origin} - worn
                      Rewards: #{a.rewards}
                      "
                    else
                      "#{a.name}: Protection: #{a.protection} Load: #{a.gearload} - worn
                      Rewards: #{a.rewards}
                      "
                    end
                  else
                    "#{a.name}: Protection: #{a.protection} Load: #{a.gearload} - worn
                    "
                  end
                elsif a.equipped == "Dropped"
                  if a.rewards
                    if a.origin
                      "#{a.name}: Protection: #{a.protection} Load: #{a.gearload} Origin: #{a.origin} - dropped
                      Rewards: #{a.rewards}
                      "
                    else
                      "#{a.name}: Protection: #{a.protection} Load: #{a.gearload} - dropped
                      Rewards: #{a.rewards}
                      "
                    end
                  else
                    "#{a.name}: Protection: #{a.protection} Load: #{a.gearload} - dropped
                    "
                  end
                end
              end
              return newlist.join("")
        end
   
   
   
    end
end