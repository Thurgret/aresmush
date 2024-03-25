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
        armour_string = Tor.armour_list(charmodel)


        combat_proficiency_string = "" + "Axes: " + charmodel.tor_axes_proficiency.to_s + "
        Bows: " + charmodel.tor_bows_proficiency.to_s + "
        Spears: " + charmodel.tor_spears_proficiency.to_s + "
        Swords: " + charmodel.tor_swords_proficiency.to_s

        
        virtue_string = ''
        
        charmodel.tor_virtues.to_a.sort_by { |a| a.name }.each_with_index.map do |a|
           virtue_string = virtue_string + a.name + ": " + a.desc + "\n"
          end

          favoured_skills_string = charmodel.favoured_skills

        
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
  favoured_skills: Website.format_markdown_for_html(favoured_skills_string) }
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
        return {}
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

       
       cultural_favoured_skills_array = Tor.cultural_favoured_skills(charmodel)
       calling_favoured_skills_array = Tor.calling_favoured_skills(charmodel)

       favoured_skills_string = charmodel.favoured_skills



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
    

    favoured_skills: Website.format_markdown_for_html(favoured_skills_string),
    
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

        Tor.initial_setup(charmodel)

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

        Tor.zero_combat_proficiencies(charmodel)
        

        Global.logger.debug cultural_favoured_skill_selection
        Global.logger.debug calling_favoured_skill_first_selection
        Global.logger.debug calling_favoured_skill_second_selection

        if (cultural_favoured_skill_selection != "-" && calling_favoured_skill_first_selection != "-" && calling_favoured_skill_second_selection != "-")
          favoured_skills_string = cultural_favoured_skill_selection + ", " + calling_favoured_skill_first_selection + ", " + calling_favoured_skill_second_selection
          Global.logger.debug favoured_skills_string
          charmodel.update(favoured_skills: favoured_skills_string)
        end

        if (first_weapon_proficiency != "-")
          Tor.set_combat_proficiency(charmodel, first_weapon_proficiency, 2)
        end
        if (second_weapon_proficiency != "-")
          Tor.set_combat_proficiency(charmodel, second_weapon_proficiency, 1)
        end

        return []
      end
      
    end
  end
end