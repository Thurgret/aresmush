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
      if (cmd.switch_is?("other"))
        return RollOtherCmd
      else
        return RollCmd
      end
    when "culturestart"
        return CultureSetCmd
    when "attributeoptions"
      if (cmd.switch_is?("set"))
        return AttributesSelectCmd
      end
      return AttributeOptionsCmd
    when "tn"
      if (cmd.switch_is?("set"))
        return TNSetCmd
      end
    when "hope"
      if (cmd.switch_is?("set"))
        return HopeSetCmd
      end
    when "endurance"
      if (cmd.switch_is?("set"))
        return EnduranceSetCmd
      end
    when "virtue"
      if (cmd.switch_is?("set"))
        return VirtueSetCmd
      end
    when "wisdom"
      if (cmd.switch_is?("set"))
        return WisdomSetCmd
      end
    when "startingcombatproficiencies"
      if (cmd.switch_is?("set"))
        return StartingCombatProfienciesSetCmd
      else
        return StartingCombatProficienciesCmd
      end
    when "wargear"
      if (cmd.switch_is?("add"))
        return WargearAddCmd
      elsif (cmd.switch_is?("discard"))
        return WargearDiscardCmd
      end
    when "equip"
      return EquipWargearCmd
    when "drop"
      return DropWargearCmd
    when "wield"
      return WargearWieldCmd
    when "store"
      return WargearStoreCmd
    when "rewards"
      if (cmd.switch_is?("add"))
        return RewardAddCmd
      end
    when "favouredskills"
      if (cmd.switch_is?("set"))
        return FavouredSkillsSetCmd
      end
    when "shadow"
      if (cmd.switch_is?("set"))
        return ShadowSetCmd
      end
    when "gearload"
      if (cmd.switch_is?("set"))
        return LoadSetCmd
      end
    when "protection"
      if (cmd.switch_is?("set"))
        return ProtectionSetCmd
      end
      
      


  
    end
    
    
    return nil
   
    
      
  end


 
    def self.get_event_handler(event_name)
      nil
   end

  
   def self.get_web_request_handler(request)
    case request.cmd
    when "addSceneRoll"
      return AddSceneRollRequestHandler
    end
   end
  end
end