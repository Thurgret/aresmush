module AresMUSH
  module Profile
    class CustomCharFields
      
      # Gets custom fields for display in a character profile.
      #
      # @param [Character] char - The character being requested.
      # @param [Character] viewer - The character viewing the profile. May be nil if someone is viewing
      #    the profile without being logged in.
      #
      # @return [Hash] - A hash containing custom fields and values. 
      #    Ansi or markdown text strings must be formatted for display.
      # @example
      #    return { goals: Website.format_markdown_for_html(char.goals) }
      def self.get_fields_for_viewing(char, viewer)
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
          treasure_string = "Treasure: " + charmodel.treasure.to_s + ", which provides for a frugal standard of living."
        elsif charmodel.treasure < 90
          treasure_string = "Treasure: " + charmodel.treasure.to_s + ", which provides for a common standard of living."
        elsif charmodel.treasure < 180
          treasure_string = "Treasure: " + charmodel.treasure.to_s + ", which provides for a prosperous standard of living."
        elsif charmodel.treasure < 300
          treasure_string = "Treasure: " + charmodel.treasure.to_s + ", which provides for a rich standard of living."
        else
          treasure_string = "Treasure: " + charmodel.treasure.to_s + ", which provides for a very rich standard of living."
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

          adventure_points_string = "Adventure Points: " + charmodel.tor_adventure_points.to_s
          skill_points_string = "Skill Points: " + charmodel.tor_skill_points.to_s



        
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
skill_points: Website.format_markdown_for_html(skill_points_string),
valour: Website.format_markdown_for_html(valour_string),
wisdom: Website.format_markdown_for_html(wisdom_string),
wounded: Website.format_markdown_for_html(wounded_string),
adventure_points: Website.format_markdown_for_html(adventure_points_string)}
  end
    
      # Gets custom fields for the character profile editor.
      #
      # @param [Character] char - The character being requested.
      # @param [Character] viewer - The character editing the profile.
      #
      # @return [Hash] - A hash containing custom fields and values. 
      #    Multi-line text strings must be formatted for editing.
      # @example
      #    return { goals: Website.format_input_for_html(char.goals) }
      def self.get_fields_for_editing(char, viewer)
        char_name = char.name
        charmodel = Character.find_one_by_name(char_name)
        wargear_list = Tor.current_wargear_list(charmodel)
        armour_options_array = Tor.armour_options(charmodel)
        shield_options_array = Tor.shield_options(charmodel)
        weapon_options_array = Tor.weapon_options(charmodel)

        wielded_equipment = Tor.wielded_equipment(charmodel)
        worn_equipment = Tor.worn_equipment(charmodel)
        dropped_equipment = Tor.dropped_equipment(charmodel)
        stored_equipment = Tor.stored_equipment(charmodel)

        return {armour_options: armour_options_array,
        shield_options: shield_options_array,
        weapon_options: weapon_options_array,
        wargear_list: wargear_list,
        wielded_equipment: wielded_equipment,
       worn_equipment: worn_equipment,
       dropped_equipment: dropped_equipment,
       stored_equipment: stored_equipment
  }
      end

      # Gets custom fields for character creation (chargen).
      #
      # @param [Character] char - The character being requested.
      #
      # @return [Hash] - A hash containing custom fields and values. 
      #    Multi-line text strings must be formatted for editing.
      # @example
      #    return { goals: Website.format_input_for_html(char.goals) }
      def self.get_fields_for_chargen(char)
        char_name = char.name
        charmodel = Character.find_one_by_name(char_name)
        strength_string = "Strength: " + Tor.attribute_rating(charmodel, "strength").to_s + "(TN: " + Tor.tn_rating(charmodel, "strength").to_s + ")"
        heart_string = "Heart: " + Tor.attribute_rating(charmodel, "heart").to_s + "(TN: " + Tor.tn_rating(charmodel, "heart").to_s + ")"
        wits_string = "Wits: " + Tor.attribute_rating(charmodel, "wits").to_s + "(TN: " + Tor.tn_rating(charmodel, "wits").to_s + ")"
        endurance_string = "Endurance: " + charmodel.tor_endurance.to_s + "(" + charmodel.tor_maxendurance.to_s + ")"
        hope_string = "Hope: " + charmodel.tor_hope.to_s + "(" + charmodel.tor_maxhope.to_s + ")"
        parry_string = "Parry: " + charmodel.tor_parry.to_s
        awe_string = "Awe: " + Tor.skill_rating(charmodel, "Awe").to_s
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



        culture = char.group("Culture")
        attribute_options = Tor.find_attribute_options_config(culture).to_a

        finalattributeoptions = ["-"]
        attribute_options.to_a.each do |option, attrs|
          if (option.is_a?(Integer))
            finalattributeoptions << option.to_s + " - " + attrs.to_s
          end
       end

       weapon_proficiency_config = Tor.find_combat_proficiencies_config(culture)
       weapon_proficiency_options = []
       weapon_proficiency_options << "-"
       weapon_proficiency_options << weapon_proficiency_config["option1"]
       weapon_proficiency_options << weapon_proficiency_config["option2"]
       second_weapon_proficiency_array = ["-", "Axes", "Bows", "Spears", "Swords"]


       common_virtues_array = ["-", "Confidence - Raise your maximum Hope rating by 2 points.", "Dour-handed - When inflicting Special Damage in combat, add +1 to your STRENGTH rating on a Heavy Blow, and +1 to the Feat Die numerical result on a Pierce.",
      "Hardiness - Raise your maximum Endurance rating by 2 points, or by your WISDOM rating, whichever is higher.", "Mastery - Choose two Skills and make them Favoured.",
    "Nimbleness - Raise your Parry raiting by 1 point.", "Prowess - Lower one of your attribute TNs by 1."]
       
       cultural_favoured_skills_array = Tor.cultural_favoured_skills(charmodel)
       calling_favoured_skills_array = Tor.calling_favoured_skills(charmodel)

       cultural_distinctive_features_array = Tor.cultural_distinctive_features(charmodel)

       favoured_skills_string = charmodel.favoured_skills


       distinctive_features_string = charmodel.distinctive_features
       armour_options_array = Tor.armour_options(charmodel)
       shield_options_array = Tor.shield_options(charmodel)
       weapon_options_array = Tor.weapon_options(charmodel)

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


       wargear_list = Tor.current_wargear_list(charmodel)

       armour_string = Tor.armour_list(charmodel)
          weapon_string = Tor.weapon_list(charmodel)
          shield_string = Tor.shield_list(charmodel)

          gearload_string = charmodel.tor_load.to_s

          fatigue_string = "Fatigue: " + charmodel.tor_fatigue.to_s
          total_load = charmodel.tor_load + charmodel.tor_fatigue
          total_load_string = "Total: " + total_load.to_s
          protection_string = "Protection: " + charmodel.tor_protection.to_s

          
          shadow_string = "Shadow: " + charmodel.tor_shadow.to_s
          shadow_scars_string = "Shadow scars: " + charmodel.tor_shadowscars.to_s
          total_shadow_string = "Total: " + charmodel.tor_shadowtotal.to_s

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

        virtue_string = ''
        
        charmodel.tor_virtues.to_a.sort_by { |a| a.name }.each_with_index.map do |a|
           virtue_string = virtue_string + a.name + ": " + a.desc + "\n"
          end

        
        return { strength: Website.format_markdown_for_html(strength_string), heart: Website.format_markdown_for_html(heart_string), wits: Website.format_markdown_for_html(wits_string),
      endurance: Website.format_markdown_for_html(endurance_string), hope: Website.format_markdown_for_html(hope_string), parry: Website.format_markdown_for_html(parry_string),
    awe: Website.format_markdown_for_html(awe_string), athletics: Website.format_markdown_for_html(athletics_string), awareness: Website.format_markdown_for_html(awareness_string),
    hunting: Website.format_markdown_for_html(hunting_string), song: Website.format_markdown_for_html(song_string), craft: Website.format_markdown_for_html(craft_string),
    enhearten: Website.format_markdown_for_html(enhearten_string), travel: Website.format_markdown_for_html(travel_string), insight: Website.format_markdown_for_html(insight_string),
    healing: Website.format_markdown_for_html(healing_string), courtesy: Website.format_markdown_for_html(courtesy_string), battle: Website.format_markdown_for_html(battle_string),
    persuade: Website.format_markdown_for_html(persuade_string), stealth: Website.format_markdown_for_html(stealth_string), scan: Website.format_markdown_for_html(scan_string),
    explore: Website.format_markdown_for_html(explore_string), riddle: Website.format_markdown_for_html(riddle_string), lore: Website.format_markdown_for_html(lore_string),
    virtue: Website.format_markdown_for_html(virtue_string),
    cultural_characteristics: Website.format_markdown_for_html(cultural_characteristics_string),
    combat_proficiency_display: Website.format_markdown_for_html(combat_proficiency_string),
    distinctive_features: Website.format_markdown_for_html(distinctive_features_string),
    armour_options: armour_options_array,
    shield_options: shield_options_array,
    weapon_options: weapon_options_array,
    wargear_list: wargear_list,
    weapons: Website.format_markdown_for_html(weapon_string),
  shields: Website.format_markdown_for_html(shield_string),
  armour: Website.format_markdown_for_html(armour_string),
  common_virtues: common_virtues_array,
  protection: Website.format_markdown_for_html(protection_string),

  shadow: Website.format_markdown_for_html(shadow_string),
shadow_scars: Website.format_markdown_for_html(shadow_scars_string),
total_shadow: Website.format_markdown_for_html(total_shadow_string),
miserable: Website.format_markdown_for_html(miserable_string),

    cultural_distinctive_features: cultural_distinctive_features_array,
    favoured_skills: Website.format_markdown_for_html(favoured_skills_string),
    gearload: Website.format_markdown_for_html(gearload_string),
    fatigue: Website.format_markdown_for_html(fatigue_string),
total_load: Website.format_markdown_for_html(total_load_string),
weary: Website.format_markdown_for_html(weary_string),
treasure: Website.format_markdown_for_html(treasure_string),
    
    cultural_favoured_skills_list: cultural_favoured_skills_array,
    calling_favoured_skills_list: calling_favoured_skills_array,
    weapon_proficiencies: weapon_proficiency_options,
    second_weapon_proficiencies: second_weapon_proficiency_array,
    first_weapon_proficiency: "",
    second_weapon_proficiency: "",
    attribute_options: finalattributeoptions, attributeoption: "" }
      end
      
      # Saves fields from profile editing.
      #
      # @param [Character] char - The character being updated.
      # @param [Hash] char_data - A hash of character fields and values. Your custom fields
      #    will be in char_data[:custom]. Multi-line text strings should be formatted for MUSH.
      #
      # @return [Array] - A list of error messages. Return an empty array ([]) if there are no errors.
      # @example
      #        char.update(goals: Website.format_input_for_mush(char_data[:custom][:goals]))
      #        return []
      def self.save_fields_from_profile_edit(char, char_data)

        char_name = char.name
        charmodel = Character.find_one_by_name(char_name)
        armour_selection = Website.format_input_for_mush(char_data[:custom][:current_armour_selection])
        weapon_selection = Website.format_input_for_mush(char_data[:custom][:weapon_selection])
        shield_selection = Website.format_input_for_mush(char_data[:custom][:shield_selection])

        wargear_discard_selection = Website.format_input_for_mush(char_data[:custom][:wargear_discard_selection])
        wargear_wear_selection = Website.format_input_for_mush(char_data[:custom][:wargear_wear_selection])
        wargear_drop_selection = Website.format_input_for_mush(char_data[:custom][:wargear_drop_selection])
        wargear_wield_selection = Website.format_input_for_mush(char_data[:custom][:wargear_wield_selection])
        wargear_store_selection = Website.format_input_for_mush(char_data[:custom][:wargear_store_selection])

        if (armour_selection != "-" && armour_selection != "" && armour_selection)
          Tor.add_armour(char, armour_selection)
        end
        if (weapon_selection != "-" && weapon_selection != "" && weapon_selection)
          Tor.add_weapon(char, weapon_selection)
        end
        if (shield_selection != "-" && shield_selection != "" && shield_selection)
          Tor.add_shield(char, shield_selection)
        end
        
        weapon_to_discard = Tor.find_weapon(charmodel, wargear_discard_selection)
        if (weapon_to_discard)
          Tor.discard_weapon(char, wargear_discard_selection)
        end
        armour_to_discard = Tor.find_armour(charmodel, wargear_discard_selection)
        if (armour_to_discard)
          Tor.discard_armour(char, wargear_discard_selection)
        end
        shield_to_discard = Tor.find_shield(charmodel, wargear_discard_selection)
        if (shield_to_discard)
          Tor.discard_shield(char, wargear_discard_selection)
        end

        armour_to_wear = Tor.find_armour(charmodel, wargear_wear_selection)
        if (armour_to_wear)
          Tor.wear_armour(char, wargear_wear_selection)
        end

        weapon_to_wear = Tor.find_weapon(charmodel, wargear_wear_selection)
        if (weapon_to_wear)
          Tor.wear_weapon(char, wargear_wear_selection)
        end

        shield_to_wear = Tor.find_shield(charmodel, wargear_wear_selection)
        if (shield_to_wear)
          Tor.wear_shield(char, wargear_wear_selection)
        end

        armour_to_drop = Tor.find_armour(charmodel, wargear_drop_selection)
        if (armour_to_drop)
          Tor.remove_armour(char, wargear_drop_selection)
        end

        weapon_to_drop = Tor.find_weapon(charmodel, wargear_drop_selection)
        if (weapon_to_drop)
          Tor.remove_weapon(char, wargear_drop_selection)
        end

        shield_to_drop = Tor.find_shield(charmodel, wargear_drop_selection)
        if (shield_to_drop)
          Tor.remove_shield(char, wargear_drop_selection)
        end


        shield_to_wield = Tor.find_shield(charmodel, wargear_wield_selection)
        if (shield_to_wield)
          Tor.hold_shield(char, wargear_wield_selection)
        end

        weapon_to_wield = Tor.find_weapon(charmodel, wargear_wield_selection)
        if (weapon_to_wield)
          Tor.wield_weapon(char, wargear_wield_selection)
        end



        weapon_to_store = Tor.find_weapon(charmodel, wargear_store_selection)
        if (weapon_to_store)
          Tor.store_weapon(char, wargear_store_selection)
        end

        shield_to_store = Tor.find_shield(charmodel, wargear_store_selection)
        if (shield_to_store)
          Tor.store_shield(char, wargear_store_selection)
        end


        return []
      end
      
      # Saves fields from character creation (chargen).
      #
      # @param [Character] char - The character being updated.
      # @param [Hash] chargen_data - A hash of character fields and values. Your custom fields
      #    will be in chargen_data[:custom]. Multi-line text strings should be formatted for MUSH.
      #
      # @return [Array] - A list of error messages. Return an empty array ([]) if there are no errors.
      # @example
      #        char.update(goals: Website.format_input_for_mush(chargen_data[:custom][:goals]))
      #        return []
      def self.save_fields_from_chargen(char, chargen_data)
        char_name = char.name
        charmodel = Character.find_one_by_name(char_name)

        if (charmodel.group("Culture").to_s != charmodel.chargen_last_selected_culture)
          Tor.initial_setup(charmodel)
          charmodel.update(chargen_last_selected_culture: charmodel.group("Culture").to_s)
        end

        attribute_option = Website.format_input_for_mush(chargen_data[:custom][:attributeoption])

        Global.logger.debug attribute_option
        if (attribute_option[0] != "-" && attribute_option != "")
          Tor.select_attributes(charmodel, attribute_option[0])
        end

        first_weapon_proficiency = Website.format_input_for_mush(chargen_data[:custom][:first_weapon_proficiency])
        second_weapon_proficiency = Website.format_input_for_mush(chargen_data[:custom][:second_weapon_proficiency])

        cultural_favoured_skill_selection = Website.format_input_for_mush(chargen_data[:custom][:cultural_favoured_skill_selection])
        calling_favoured_skill_first_selection = Website.format_input_for_mush(chargen_data[:custom][:calling_favoured_skill_first_selection])
        calling_favoured_skill_second_selection = Website.format_input_for_mush(chargen_data[:custom][:calling_favoured_skill_second_selection])

        first_distinctive_feature = Website.format_input_for_mush(chargen_data[:custom][:distinctive_feature_first_selection])
        second_distinctive_feature = Website.format_input_for_mush(chargen_data[:custom][:distinctive_feature_second_selection])

        armour_selection = Website.format_input_for_mush(chargen_data[:custom][:armour_selection])
        weapon_selection = Website.format_input_for_mush(chargen_data[:custom][:weapon_selection])
        shield_selection = Website.format_input_for_mush(chargen_data[:custom][:shield_selection])

        wargear_discard_selection = Website.format_input_for_mush(chargen_data[:custom][:wargear_discard_selection])

        virtue_selection = Website.format_input_for_mush(chargen_data[:custom][:virtue_selection])



        if (virtue_selection && virtue_selection != "-" && virtue_selection != "")
          if (virtue_selection == "Confidence - Raise your maximum Hope rating by 2 points.")
            Tor.remove_starting_virtues(charmodel)
            Tor.virtue_set(charmodel, "Confidence")
          elsif (virtue_selection == "Dour-handed - When inflicting Special Damage in combat, add +1 to your STRENGTH rating on a Heavy Blow, and +1 to the Feat Die numerical result on a Pierce.")
            Tor.remove_starting_virtues(charmodel)
              Tor.virtue_set(charmodel, "Dour-handed")
          elsif (virtue_selection == "Hardiness - Raise your maximum Endurance rating by 2 points, or by your WISDOM rating, whichever is higher.")
            Tor.remove_starting_virtues(charmodel)
              Tor.virtue_set(charmodel, "Hardiness")
          elsif (virtue_selection == "Mastery - Choose two Skills and make them Favoured.")
            Tor.remove_starting_virtues(charmodel)
                Tor.virtue_set(charmodel, "Mastery")
          elsif (virtue_selection == "Nimbleness - Raise your Parry raiting by 1 point.")
            Tor.remove_starting_virtues(charmodel)
                Tor.virtue_set(charmodel, "Nimbleness")
          elsif (virtue_selection == "Prowess - Lower one of your attribute TNs by 1.")
            Tor.remove_starting_virtues(charmodel)
                 Tor.virtue_set(charmodel, "Prowess")
          end
        end
        
        


        if (cultural_favoured_skill_selection != "-" && calling_favoured_skill_first_selection != "-" && calling_favoured_skill_second_selection != "-" &&
          cultural_favoured_skill_selection != "" && calling_favoured_skill_first_selection != "" && calling_favoured_skill_second_selection != "" &&
          cultural_favoured_skill_selection && calling_favoured_skill_first_selection && calling_favoured_skill_second_selection)
          favoured_skills_string = cultural_favoured_skill_selection + ", " + calling_favoured_skill_first_selection + ", " + calling_favoured_skill_second_selection
          Tor.update_favoured_skills(charmodel, favoured_skills_string)
        end



        if (first_weapon_proficiency != "-" && first_weapon_proficiency != "" && first_weapon_proficiency &&
          second_weapon_proficiency != "-" && second_weapon_proficiency != "" && second_weapon_proficiency)
          Tor.zero_combat_proficiencies(charmodel)
          Tor.set_combat_proficiency(charmodel, first_weapon_proficiency, 2)
          Tor.set_combat_proficiency(charmodel, second_weapon_proficiency, 1)
        end

        if (first_distinctive_feature != "-" && second_distinctive_feature != "-" &&
          first_distinctive_feature != "" && second_distinctive_feature != "" &&
          first_distinctive_feature && second_distinctive_feature)
          Tor.set_distinctive_features(charmodel, first_distinctive_feature, second_distinctive_feature)
        end

        if (armour_selection != "-" && armour_selection != "" && armour_selection)
          Tor.add_armour(charmodel, armour_selection)
        end
        if (weapon_selection != "-" && weapon_selection != "" && weapon_selection)
          Tor.add_weapon(charmodel, weapon_selection)
        end
        if (shield_selection != "-" && shield_selection != "" && shield_selection)
          Tor.add_shield(charmodel, shield_selection)
        end
        
        weapon_to_discard = Tor.find_weapon(charmodel, wargear_discard_selection)
        if (weapon_to_discard)
          Tor.discard_weapon(charmodel, wargear_discard_selection)
        end
        armour_to_discard = Tor.find_armour(charmodel, wargear_discard_selection)
        if (armour_to_discard)
          Tor.discard_armour(charmodel, wargear_discard_selection)
        end
        shield_to_discard = Tor.find_shield(charmodel, wargear_discard_selection)
        if (shield_to_discard)
          Tor.discard_shield(charmodel, wargear_discard_selection)
        end

        return []
      end
      
    end
  end
end