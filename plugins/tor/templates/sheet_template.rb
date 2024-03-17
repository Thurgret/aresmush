module AresMUSH    
    module Tor
      class SheetTemplate < ErbTemplateRenderer
        attr_accessor :char
    
        def initialize(char)
          @char = char
          super File.dirname(__FILE__) + "/sheet.erb"
        end



        def format_two_per_line(list)
          list.to_a.sort_by { |a| a.name }
            .each_with_index
              .map do |a, i| 
                linebreak = i % 2 == 0 ? "\n" : ""
                title = left("#{ a.name }:", 15)
                rating = left(a.rating, 20)
                "#{linebreak}%xh#{title}%xn #{rating}"
          end
        end

        def format_tn_two_per_line(list)
          list.to_a.sort_by { |a| a.name }
            .each_with_index
              .map do |a, i| 
                linebreak = i % 2 == 0 ? "\n" : ""
                title = left("#{ a.name }:", 15)
                target_number = left(a.target_number, 20)
                "#{linebreak}%xh#{title}%xn #{target_number}"
          end
        end
        
        def skills
          format_two_per_line @char.tor_skills
        end


        def attrs
          format_two_per_line @char.tor_attributes
        end

        def targetnumbers
          format_tn_two_per_line @char.tor_tn
        end

        def sheettitle
          firstline = @char.group("Culture").to_s
          name = @char.name.to_s
          "\n" + name + " of the " + firstline + "\n"
        end

        def attributes
          firstline = left(("Strength: " + Tor.attribute_rating(@char, "strength").to_s + "(TN: " + Tor.tn_rating(@char, "strength").to_s + ")"), 20) + center(("Heart: " + Tor.attribute_rating(@char, "heart").to_s + "(TN: " + Tor.tn_rating(@char, "heart").to_s + ")"), 20) + right(("Wits: " + Tor.attribute_rating(@char, "wits").to_s + "(TN: " + Tor.tn_rating(@char, "wits").to_s + ")"), 20)
          "" + firstline + "\n"
        end

        def derived_stats
          firstline = left(("Endurance: " + @char.tor_endurance.to_s + "(" + @char.tor_maxendurance.to_s + ")"), 20) + center(("Hope: " + @char.tor_hope.to_s + "(" + @char.tor_maxhope.to_s + ")"), 20) + right(("Parry: " + @char.tor_parry.to_s), 20)
          "" + firstline + "\n"
        end

        def wisdom_and_valour
          firstline = left(("Wisdom: " + @char.tor_wisdom.to_s), 20) + center(("Valour: " + @char.tor_valour.to_s), 20)
          "\n" + firstline + "\n"
        end

        def virtues        
          @char.tor_virtues.to_a.sort_by { |a| a.name }.each_with_index.map do |a| 
            "" + a.name + ": " + a.desc + "\n\n"
          end
        end

        def shadow
          firstline = left(("Shadow: " + @char.tor_shadow.to_s), 20) + center(("Shadow Scars: " + @char.tor_shadowscars.to_s), 20) + right(("Total Shadow: " + @char.tor_shadowtotal.to_s), 20)
        end

        def adventure_and_skill_points
          firstline = left(("Current Adventure Points: " + @char.tor_adventure_points.to_s), 35) + right(("Total Adventure Points: " + @char.tor_lifetime_adventure_points.to_s), 35)
          secondline = left(("Current Skill Points: " + @char.tor_skill_points.to_s), 35) + right(("Total Skill Points: " + @char.tor_lifetime_skill_points.to_s), 35)
          "" + firstline + "\n" + secondline + "\n"
        end

        
      end
    end
  end