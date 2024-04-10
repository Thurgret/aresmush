module AresMUSH
    module Tor
   
   


        def self.cultural_characteristics(char)
            culture = char.group("Culture").to_s.downcase
            if (culture == "bardings")
                return "Stout-hearted: Your valour rolls are favoured."
            elsif (culture == "bree-folk")
                return "Bree-blood: Each Bree-folk hero in the Company increases its fellowship rating by 1."
            elsif (culture == "dwarves of durin's folk")
                return "Redoubtable: You halve the load rating of any armour you're wearing.
                Naugrim: Dwarven adventurers cannot use certain wargear."
            elsif (culture == "elves of lindon")
                return "Elven-skill: If you are not miserable, you can spend 1 point of hope to achieve a magical success on a roll, provided you have at least one point in the skill being rolled.
                The Long Defeat: You may only remove a maximum of 1 point of Shadow during the fellowship phase."    
            elsif (culture == "elves of rivendell")
                return "Elven-wise: Add 1 point to one attribute. If you are not miserable, you can spend 1 point of hope to achieve a magical success on a skill roll.
                Beset by Woe: You can remove accumulated Shadow points exclusively during a Yule fellowship phase."
            elsif (culture == "hobbits of the shire")
                return "Hobbit-sense: Your wisdom rolls are Favoured, and you gain 1 extra success die on all Shadow tests made to resist the effects of greed.
                Halflings: Hobbits cannot use larger weapons effectively and have access to limited amounts of wargear."    
            elsif (culture == "rangers of the north")
                return "Kings of Men: Add 1 point to one attribute.
                Allegiance of the Dúnedain: During the fellowship phase, you recover a maximum number of hope points equal to half your heart."
            end
        end


        #newlist = list.to_a.sort_by { |a| a.name }
       # .each_with_index
          #.map do |a, i|

        def self.armour_list(char)
            list = char.tor_armour.to_a.each.map do |a|
                if a.equipped == "Equipped"
                  if (a.rewards && a.rewards != "")
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
                  if (a.rewards && a.rewards != "")
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
              return list.join("")
        end

        def self.weapon_list(char)
          list = char.tor_weapons.to_a.each.map do |a|
            if (a.equipped == "Equipped")
              if (a.wielded == "in hand")
                if a.rewards
                  if a.origin
                    "#{a.name}: Damage: #{a.damage} Injury: #{a.injury} Load: #{a.gearload} Origin: #{a.origin} - in hand\nRewards: #{a.rewards}\n"
                  else
                    "#{a.name}: Damage: #{a.damage} Injury: #{a.injury} Load: #{a.gearload} - in hand\nRewards: #{a.rewards}\n"
                  end
                else
                  "#{a.name}: Damage: #{a.damage} Injury: #{a.injury} Load: #{a.gearload} - in hand\n"
                end
              else
                if (a.rewards != "")
                  if a.origin
                    "#{a.name}: Damage: #{a.damage} Injury: #{a.injury} Load: #{a.gearload} Origin: #{a.origin} - worn\nRewards: #{a.rewards}\n"
                  else
                    "#{a.name}: Damage: #{a.damage} Injury: #{a.injury} Load: #{a.gearload} - worn\nRewards: #{a.rewards}\n"
                  end
                else
                  "#{a.name}: Damage: #{a.damage} Injury: #{a.injury} Load: #{a.gearload} - worn\n"
                end
              end
            elsif a.equipped == "Dropped"
              if a.rewards
                if a.origin
                  "#{a.name}: Damage: #{a.damage} Injury: #{a.injury} Load: #{a.gearload} Origin: #{a.origin} - dropped\nRewards: #{a.rewards}\n"
                else
                  "#{a.name}: Damage: #{a.damage} Injury: #{a.injury} Load: #{a.gearload} - dropped\nRewards: #{a.rewards}\n"
                end
              else
                "#{a.name}: Damage: #{a.damage} Injury: #{a.injury} Load: #{a.gearload} - dropped\n"
              end
            end
          end
          return list.join("")
        end

        def self.shield_list(char)
          list = char.tor_shields.to_a.each.map do |a|
                    if (a.equipped == "Equipped")
                      if (a.wielded == "in hand")
                        if (a.rewards && a.rewards != "")
                          if a.origin
                            "#{a.name}: Parry Modifier: #{a.parrymodifier} Load: #{a.gearload} Origin: #{a.origin} - in hand\nRewards: #{a.rewards}\n"
                          else
                            "#{a.name}: Parry Modifier: #{a.parrymodifier} Load: #{a.gearload} - in hand\nRewards: #{a.rewards}\n"
                          end
                        else
                          "#{a.name}: Parry Modifier: #{a.parrymodifier} Load: #{a.gearload} - in hand\n"
                        end
                      else
                        if (a.rewards && a.rewards != "")
                          if a.origin
                            "#{a.name}: Parry Modifier: #{a.parrymodifier} Load: #{a.gearload} Origin: #{a.origin} - worn\nRewards: #{a.rewards}\n"
                          else
                            "#{a.name}: Parry Modifier: #{a.parrymodifier} Load: #{a.gearload} - worn\nRewards: #{a.rewards}\n"
                          end
                        else
                          "#{a.name}: Parry Modifier: #{a.parrymodifier} Load: #{a.gearload} - worn\n"
                        end
                      end
                    elsif a.equipped == "Dropped"
                      if (a.rewards && a.rewards != "")
                        if a.origin
                          "#{a.name}: Parry Modifier: #{a.parrymodifier} Load: #{a.gearload} Origin: #{a.origin} - dropped\nRewards: #{a.rewards}\n"
                        else
                          "#{a.name}: Parry Modifier: #{a.parrymodifier} Load: #{a.gearload} - dropped\nRewards: #{a.rewards}\n"
                        end
                      else
                        "#{a.name}: Parry Modifier: #{a.parrymodifier} Load: #{a.gearload} - dropped\n"
                      end
                    end
                  end
                  return list.join("")
                end



        def self.cultural_favoured_skills(model)
          culture = model.group("Culture").to_s.downcase
          if (culture == "bardings")
            return ["-", "Athletics", "Enhearten"]
          elsif (culture == "bree-folk")
            return ["-", "Insight", "Riddle"]
          elsif (culture == "dwarves of durin's folk")
            return ["-", "Craft", "Travel"]
          elsif (culture == "elves of lindon")
            return ["-", "Song", "Lore"]
          elsif (culture == "elves of rivendell")
            return ["-", "Awareness", "Healing"]
          elsif (culture == "hobbits of the shire")
            return ["-", "Courtesy", "Stealth"]
          elsif (culture == "rangers of the north")
            return ["-", "Hunting", "Lore"]
          end
        end

        def self.calling_favoured_skills(model)
          calling = model.group("Calling").to_s.downcase
          if (calling == "captain")
            return ["-", "Battle", "Enhearten", "Persuade"]
          elsif (calling == "champion")
            return ["-", "Athletics", "Awe", "Hunting"]
          elsif (calling == "messenger")
            return ["-", "Courtesy", "Song", "Travel"]
          elsif (calling == "scholar")
            return ["-", "Craft", "Lore", "Riddle"]
          elsif (calling == "treasure hunter")
            return ["-", "Explore", "Scan", "Stealth"]
          elsif (calling == "warden")
            return ["-", "Awareness", "Healing", "Insight"]
          end
        end


        def self.cultural_distinctive_features(model)
          culture = model.group("Culture").to_s.downcase
          if (culture == "bardings")
            return ["-", "Bold", "Eager", "Fair", "Fierce", "Generous", "Proud", "Tall", "Wilful"]
          elsif (culture == "bree-folk")
            return ["-", "Cunning", "Fair-spoken", "Faithful", "Generous", "Inquisitive", "Patient", "Rustic", "True-hearted"]
          elsif (culture == "dwarves of durin's folk")
            return ["-", "Cunning", "Fierce", "Lordly", "Proud", "Secretive", "Stern", "Wary", "Wilful"]
          elsif (culture == "elves of lindon")
            return ["-", "Fair", "Keen-eyed", "Lordly", "Merry", "Patient", "Subtle", "Swift", "Wary"]
          elsif (culture == "elves of rivendell")
            return ["-", "Fair", "Inquisitive", "Keen-eyed", "Lordly", "Merry", "Proud", "Subtle", "Wilful"]
          elsif (culture == "hobbits of the shire")
            return ["-", "Eager", "Fair-spoken", "Faithful", "Honourable", "Inquisitive", "Keen-eyed", "Merry", "Rustic"]
          elsif (culture == "rangers of the north")
            return ["-", "Bold", "Honourable", "Secretive", "Stern", "Subtle", "Swift", "Tall", "True-hearted"]
          end
        end



      def self.calling_distinctive_feature(model)
        calling = model.group("Calling").to_s.downcase
          if (calling == "captain")
            return "Leadership"
          elsif (calling == "champion")
            return "Enemy Lore"
          elsif (calling == "messenger")
            return "Folk-lore"
          elsif (calling == "scholar")
            return "Rhymes of Lore"
          elsif (calling == "treasure hunter")
            return "Burglary"
          elsif (calling == "warden")
            return "Shadow-lore"
          end
      
      end

      def self.armour_options(model)
        treasure = model.treasure
        if (treasure >= 90)
          return ["-", "Leather Shirt", "Leather Corslet", "Mail Shirt", "Coat of Mail", "Helm"]
        elsif (treasure >= 30)
          return ["-", "Leather Shirt", "Leather Corslet", "Mail Shirt", "Helm"]
        else
          return ["-", "Leather Shirt", "Leather Corslet", "Helm"]
        end

      end

      def self.weapon_options(model)
        treasure = model.treasure
        culture = model.group("Culture").to_s.downcase
      end

      def self.shield_options(model)
        treasure = model.treasure
        culture = model.group("Culture").to_s.downcase
        if (culture == "dwarves of durin's folk" || culture == "hobbits of the shire")
          if (treasure >= 30)
            return ["-", "Buckler", "Shield"]
          else
            return ["-", "Buckler"]
          end  
        elsif (treasure >= 90)
          return ["-", "Buckler", "Shield", "Great Shield"]
        elsif (treasure >= 30)
          return ["-", "Buckler", "Shield"]
        else
          return ["-", "Buckler"]
        end
      end

     
      def self.weapon_options(model)
        treasure = model.treasure
        culture = model.group("Culture").to_s.downcase
        
        if (culture == "hobbits of the shire")
          return ["-", "Axe", "Bow", "Club", "Cudgel", "Dagger", "Short Sword", "Short Spear", "Spear"]
        elsif (culture == "dwarves of durin's folk")
          return ["-", "Dagger", "Cudgel", "Club", "Short Sword", "Sword", "Long Sword",
        "Short Spear", "Spear", "Axe", "Long-hafted Axe", "Great Axe", "Mattock",
      "Bow"]
        else
          return ["-", "Dagger", "Cudgel", "Club", "Short Sword", "Sword", "Long Sword",
          "Short Spear", "Spear", "Great Spear", "Axe", "Long-hafted Axe", "Great Axe", "Mattock",
        "Bow", "Great Bow"]
        end
      end


      def self.current_wargear_list(model)
        list = ["-"]
        model.tor_weapons.each do |a|
          list << a.name
        end
        model.tor_armour.each do |a|
          list << a.name
        end
        model.tor_shields.each do |a|
          list << a.name
        end
        return list
      end

      def self.wielded_equipment(model)
        list = ["-"]
        model.tor_weapons.each do |a|
          if (a.wielded == "in hand")
            list << a.name
          end
        end
        model.tor_shields.each do |a|
          if (a.wielded == "in hand")
            list << a.name
          end
        end
        return list
      end

      def self.stored_equipment(model)
        list = ["-"]
        model.tor_weapons.each do |a|
          if (a.wielded == "stored")
            list << a.name
          end
        end
        model.tor_shields.each do |a|
          if (a.wielded == "stored")
            list << a.name
          end
        end
        return list
      end

      def self.worn_equipment(model)
        list = ["-"]
        model.tor_weapons.each do |a|
          if (a.equipped == "Equipped")
            list << a.name
          end
        end
        model.tor_armour.each do |a|
          if (a.equipped == "Equipped")
            list << a.name
          end
        end
        model.tor_shields.each do |a|
          if (a.equipped == "Equipped")
            list << a.name
          end
        end
        return list
      end

      def self.dropped_equipment(model)
        list = ["-"]
        model.tor_weapons.each do |a|
          if (a.equipped == "Dropped")
            list << a.name
          end
        end
        model.tor_armour.each do |a|
          if (a.equipped == "Dropped")
            list << a.name
          end
        end
        model.tor_shields.each do |a|
          if (a.equipped == "Dropped")
            list << a.name
          end
        end
        return list
      end


   
   
   
    end
end