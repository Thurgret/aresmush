module AresMUSH    
    module Tor
      
        class AttributesCmd
        
            include CommandHandler
    
       
            def handle
        
                # Get the hash of attributes out of the configuration
                attrs = Global.read_config("tor", "attributes")
          
                # Sort the hash and then convert it to a list of the form "Name Description"
                list = attrs.sort_by { |a| a['name']}
                  .map { |a| "%xh#{a['name'].ljust(15)}%xn #{a['desc']}"}
                      
         
                  # Use the standard bordered list template to show the list with a title above it.
                  template = BorderedListTemplate.new list, t('tor.attributes_title')
                  client.emit template.render
      
                end
            end
        end
    end