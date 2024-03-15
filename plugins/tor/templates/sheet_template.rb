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
        
      end
    end
  end