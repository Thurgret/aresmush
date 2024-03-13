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
                targetnumbers = left(a.target_number, 20)
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
          format_two_per_line @char.tor_tn
        end
        
      end
    end
  end