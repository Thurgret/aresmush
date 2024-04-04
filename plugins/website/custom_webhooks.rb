module AresMUSH
  module Website
    def self.custom_webhooks(request)
      #if (request.args['cmd'] == 'yourcommand')
      #  ...do something with the command...
      #  return {}
      #end
      
      # Always return {}.

      if (request.args['cmd'] == "torcombatabilities")
        Global.logger.debug "Got the request"
        combatabilities = ["Axes", "Bows", "Spears", "Swords", "Protection"]

        return combatabilities
      end


      return {}
    end
  end
end