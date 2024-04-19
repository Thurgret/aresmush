module AresMUSH
  module Scenes
    
    def self.custom_char_card_fields(char, viewer)
      
      # Return nil if you don't need any custom fields.
      #return nil
      
      # Otherwise return a hash of data.  For example, if you want to show traits you could do:
      # {
      #   traits: char.traits.map { |k, v| { name: k, description: v } }
      # }
      char_name = char.name
        charmodel = Character.find_one_by_name(char_name)
        strength_string = "Strength: " + Tor.attribute_rating(charmodel, "strength").to_s + "(TN: " + Tor.tn_rating(charmodel, "strength").to_s + ")"
        heart_string = "Heart: " + Tor.attribute_rating(charmodel, "heart").to_s + "(TN: " + Tor.tn_rating(charmodel, "heart").to_s + ")"
        wits_string = "Wits: " + Tor.attribute_rating(charmodel, "wits").to_s + "(TN: " + Tor.tn_rating(charmodel, "wits").to_s + ")"
        endurance_string = "Endurance: " + charmodel.tor_endurance.to_s + "(" + charmodel.tor_maxendurance.to_s + ")"
        hope_string = "Hope: " + charmodel.tor_hope.to_s + "(" + charmodel.tor_maxhope.to_s + ")"
        parry_string = "Parry: " + charmodel.tor_parry.to_s
        awe_string = "Awe: " + Tor.skill_rating(char, "Awe").to_s
        athletics_string = "Athletics: " + Tor.skill_rating(charmodel, "Athletics").to_s
        awareness_string = "Awareness: " + Tor.skill_rating(charmodel, "Awareness").to_s
        hunting_string = "Hunting: " + Tor.skill_rating(charmodel, "Hunting").to_s
        song_string = "Song: " + Tor.skill_rating(charmodel, "Song").to_s
        craft_string = "Craft: " + Tor.skill_rating(charmodel, "Craft").to_s
        enhearten_string = "Enhearten: " + Tor.skill_rating(charmodel, "Enhearten").to_s
        travel_string = "Travel: " + Tor.skill_rating(charmodel, "Travel").to_s
        insight_string = "Insight: " + Tor.skill_rating(charmodel, "Insight").to_s
        healing_string = "Healing: " + Tor.skill_rating(charmodel, "Healing").to_s
        courtesy_string = "Courtesy: " + Tor.skill_rating(charmodel, "Courtesy").to_s
        battle_string = "Battle: " + Tor.skill_rating(charmodel, "Battle").to_s
        persuade_string = "Persuade: " + Tor.skill_rating(charmodel, "Persuade").to_s
        stealth_string = "Stealth: " + Tor.skill_rating(charmodel, "Stealth").to_s
        scan_string = "Scan: " + Tor.skill_rating(charmodel, "Scan").to_s
        explore_string = "Explore: " + Tor.skill_rating(charmodel, "Explore").to_s
        riddle_string = "Riddle: " + Tor.skill_rating(charmodel, "Riddle").to_s
        lore_string = "Lore: " + Tor.skill_rating(charmodel, "Lore").to_s

        cultural_characteristics_string = Tor.cultural_characteristics(charmodel)
        

        combat_proficiency_string = "" + "Axes: " + charmodel.tor_axes_proficiency.to_s + "
        Bows: " + charmodel.tor_bows_proficiency.to_s + "
        Spears: " + charmodel.tor_spears_proficiency.to_s + "
        Swords: " + charmodel.tor_swords_proficiency.to_s

        
        virtue_string = ''
        
        charmodel.tor_virtues.to_a.sort_by { |a| a.name }.each_with_index.map do |a|
           virtue_string = virtue_string + a.name + ": " + a.desc + "\n"
          end

          favoured_skills_string = charmodel.favoured_skills

          valour_string = "Valour: " + charmodel.tor_valour.to_s
          wisdom_string = "Wisdom: " + charmodel.tor_wisdom.to_s
          if (charmodel.wounded.to_s.downcase == "wounded")
            wounded_string = "Wounded"
          else
            wounded_string = "Not wounded"
          end
          
       
          distinctive_features_string = charmodel.distinctive_features

          armour_string = Tor.armour_list(charmodel)
          weapon_string = Tor.weapon_list(charmodel)
          shield_string = Tor.shield_list(charmodel)

          gearload_string = "Load: " + charmodel.tor_load.to_s
          fatigue_string = "Fatigue: " + charmodel.tor_fatigue.to_s
          total_load = charmodel.tor_load + charmodel.tor_fatigue
          total_load_string = "Total: " + total_load.to_s
          protection_string = "Protection: " + charmodel.tor_protection.to_s

          shadow_string = "Shadow: " + charmodel.tor_shadow.to_s
          shadow_scars_string = "Shadow scars: " + charmodel.tor_shadowscars.to_s
          total_shadow_string = "Total: " + charmodel.tor_shadowtotal.to_s

        if charmodel.treasure < 30
          treasure_string = "Treasure: " + charmodel.treasure.to_s + " which provides for a frugal standard of living."
        elsif charmodel.treasure < 90
          treasure_string = "Treasure: " + charmodel.treasure.to_s + " which provides for a common standard of living."
        elsif charmodel.treasure < 180
          treasure_string = "Treasure: " + charmodel.treasure.to_s + " which provides for a prosperous standard of living."
        elsif charmodel.treasure < 300
          treasure_string = "Treasure: " + charmodel.treasure.to_s + " which provides for a rich standard of living."
        else
          treasure_string = "Treasure: " + charmodel.treasure.to_s + " which provides for a very rich standard of living."
        end


          if charmodel.tor_shadowtotal >= charmodel.tor_hope
            miserable_string = "Miserable"
          else
            miserable_string = "Not miserable"
          end

          if total_load >= charmodel.tor_endurance
            weary_string = "Weary"
          else
            weary_string = "Not weary"
          end



        
        return { strength: Website.format_markdown_for_html(strength_string), heart: Website.format_markdown_for_html(heart_string), wits: Website.format_markdown_for_html(wits_string),
      endurance: Website.format_markdown_for_html(endurance_string), hope: Website.format_markdown_for_html(hope_string), parry: Website.format_markdown_for_html(parry_string),
    awe: Website.format_markdown_for_html(awe_string), athletics: Website.format_markdown_for_html(athletics_string), awareness: Website.format_markdown_for_html(awareness_string),
    hunting: Website.format_markdown_for_html(hunting_string), song: Website.format_markdown_for_html(song_string), craft: Website.format_markdown_for_html(craft_string),
    enhearten: Website.format_markdown_for_html(enhearten_string), travel: Website.format_markdown_for_html(travel_string), insight: Website.format_markdown_for_html(insight_string),
    healing: Website.format_markdown_for_html(healing_string), courtesy: Website.format_markdown_for_html(courtesy_string), battle: Website.format_markdown_for_html(battle_string),
    persuade: Website.format_markdown_for_html(persuade_string), stealth: Website.format_markdown_for_html(stealth_string), scan: Website.format_markdown_for_html(scan_string),
    explore: Website.format_markdown_for_html(explore_string), riddle: Website.format_markdown_for_html(riddle_string), lore: Website.format_markdown_for_html(lore_string),
    virtue: Website.format_markdown_for_html(virtue_string), cultural_characteristics: Website.format_markdown_for_html(cultural_characteristics_string),
    armour: Website.format_markdown_for_html(armour_string), combat_proficiency_display: Website.format_markdown_for_html(combat_proficiency_string),
  favoured_skills: Website.format_markdown_for_html(favoured_skills_string),
  distinctive_features: Website.format_markdown_for_html(distinctive_features_string),
   weapons: Website.format_markdown_for_html(weapon_string),
  shields: Website.format_markdown_for_html(shield_string),
  gearload: Website.format_markdown_for_html(gearload_string),
protection: Website.format_markdown_for_html(protection_string),
fatigue: Website.format_markdown_for_html(fatigue_string),
total_load: Website.format_markdown_for_html(total_load_string),
weary: Website.format_markdown_for_html(weary_string),
shadow: Website.format_markdown_for_html(shadow_string),
shadow_scars: Website.format_markdown_for_html(shadow_scars_string),
total_shadow: Website.format_markdown_for_html(total_shadow_string),
miserable: Website.format_markdown_for_html(miserable_string),
treasure: Website.format_markdown_for_html(treasure_string),
valour: Website.format_markdown_for_html(valour_string),
wisdom: Website.format_markdown_for_html(wisdom_string),
wounded: Website.format_markdown_for_html(wounded_string)}
    end
  end
end
