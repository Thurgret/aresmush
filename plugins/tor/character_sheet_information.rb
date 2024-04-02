module AresMUSH
    module Tor
   
   


        def self.cultural_characteristics(char)
            culture = char.group("Culture").to_s.downcase
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
                Halflings:  Due to their reduced size, Hobbits cannot use larger weapons effectively. The weapons available to Hobbits are: axe, bow, club, cudgel, dagger, short sword, short spear, spear. Additionally, Hobbits cannot use a great shield."    
            elsif (culture == "rangers of the north")
                return "Kings of Men: Add 1 point to one Attribute of your choice.
                Allegiance of the Dúnedain: During the Fellow ship phase (not Yule) you recover a maximum number of Hope points equal to half your HEART score (rounding fractions up)."
            end
        end


        #newlist = list.to_a.sort_by { |a| a.name }
       # .each_with_index
          #.map do |a, i|

        def self.armour_list(char)
            list = char.tor_armour.to_a.each.map do |a|
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
                  "#{a.name}: Damage: #{a.damage} Injury: #{a.injury} Load: #{a.gearload} - in hand
                  "
                end
              else
                if (a.rewards != "")
                  if a.origin
                    "#{a.name}: Damage: #{a.damage} Injury: #{a.injury} Load: #{a.gearload} Origin: #{a.origin} - worn
                    Rewards: #{a.rewards}
                    "
                  else
                    "#{a.name}: Damage: #{a.damage} Injury: #{a.injury} Load: #{a.gearload} - worn
                    Rewards: #{a.rewards}
                    "
                  end
                else
                  "#{a.name}: Damage: #{a.damage} Injury: #{a.injury} Load: #{a.gearload} - worn
                  "
                end
              end
            elsif a.equipped == "Dropped"
              if a.rewards
                if a.origin
                  "#{a.name}: Damage: #{a.damage} Injury: #{a.injury} Load: #{a.gearload} Origin: #{a.origin} - dropped
                  Rewards: #{a.rewards}
                  "
                else
                  "#{a.name}: Damage: #{a.damage} Injury: #{a.injury} Load: #{a.gearload} - dropped
                  Rewards: #{a.rewards}
                  "
                end
              else
                "#{a.name}: Damage: #{a.damage} Injury: #{a.injury} Load: #{a.gearload} - dropped
                "
              end
            end
          end
          return list.join("")
        end

        def self.shield_list(char)
          list = char.tor_shields.to_a.each.map do |a|
                    if (a.equipped == "Equipped")
                      if (a.wielded == "in hand")
                        if a.rewards
                          if a.origin
                            "#{a.name}: Parry Modifier: #{a.parrymodifier} Load: #{a.gearload} Origin: #{a.origin} - in hand\nRewards: #{a.rewards}\n"
                          else
                            "#{a.name}: Parry Modifier: #{a.parrymodifier} Load: #{a.gearload} - in hand\nRewards: #{a.rewards}\n"
                          end
                        else
                          "#{a.name}: Parry Modifier: #{a.parrymodifier} Load: #{a.gearload} - in hand\n"
                        end
                      else
                        if a.rewards
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
                      if a.rewards
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
            return ["-", "Fair-spoken", "Faithful", "Generous", "Inquisitive", "Patient", "Rustic", "True-hearted"]
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