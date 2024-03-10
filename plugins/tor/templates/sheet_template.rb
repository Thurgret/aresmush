module AresMUSH    
    module Tor
      class SheetTemplate < ErbTemplateRenderer
        attr_accessor :char
    
        def initialize(char)
          @char = char
          super File.dirname(__FILE__) + "/sheet.erb"
        end
    
        def attrs
          format_two_per_line @char.tor_attributes
        end
        
        def format_two_per_line(list)
          list.to_a.sort_by { |a| a.name }
            .each_with_index
              .map do |a, i| 
                linebreak = i % 2 == 0 ? "\n" : ""
                title = left("#{ a.name }:", 15)
                step = left(a.rating, 20)
                "#{linebreak}%xh#{title}%xn #{step}"
          end
        end
        

        def skills
          @char.tor_skills.to_a.sort_by { |a| a.name }
        end
        
      end
    end
  end