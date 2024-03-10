module AresMUSH
   module Tor

   
    def self.plugin_dir
      File.dirname(__FILE__)
  
    end

   def self.shortcuts
     Global.read_config("tor", "shortcuts")
   end

   
   
   def self.get_cmd_handler(client, cmd, enactor)
    case cmd.root
    when "attribute"
      if (cmd.switch_is?("set"))
        return AttributeSetCmd
      else
        return AttributesCmd
      end
    when "skill"
      if (cmd.switch_is?("set"))
        return SkillSetCmd
      else
        return SkillsCmd
      end
    when "sheet"
      return SheetCmd
    when "roll"
      return RollCmd
    end

     
    return nil
   
    
    end


   def self.get_event_handler(event_name)
     nil
   end

   def self.get_web_request_handler(request)
     nil
   end
  end
end