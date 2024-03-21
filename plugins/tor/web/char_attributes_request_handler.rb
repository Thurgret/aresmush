module AresMUSH
    module Tor
      class CharAttributesRequestHandler
        def handle(request)
          char = Character.find_one_by_name request.args[:id]
          
          if (!char)
            return []
          end
  
          error = Website.check_login(request, true)
          return error if error
          

          culture = char.group("Culture")



          options = Tor.find_attribute_options_config(culture)

        
          finaloptions = []

          options.each do |option, attrs, rating|
            finaloptions << attrs.to_s + rating
            Global.logger.debug attrs.to_s
          end

          
          return finaloptions
        end
      end
    end
  end
  
  
  