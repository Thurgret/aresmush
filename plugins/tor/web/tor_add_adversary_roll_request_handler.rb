module AresMUSH
    module Tor
      class AddAdversaryRollRequestHandler
        def handle(request)
          scene = Scene[request.args[:id]]
          enactor = request.enactor
          sender_name = request.args[:sender]
          
          error = Website.check_login(request)
          return error if error
  
          request.log_request
          
          sender = Character.named(sender_name)
          if (!sender)
            return { error: t('webportal.not_found') }
          end
          
          if (!AresCentral.is_alt?(sender, enactor))
            return { error: t('dispatcher.not_allowed') }
          end
          
          if (!scene)
            return { error: t('webportal.not_found') }
          end
          
          if (!Scenes.can_read_scene?(enactor, scene))
            return { error: t('scenes.access_not_allowed') }
          end
          
          if (scene.completed)
            return { error: t('scenes.scene_already_completed') }
          end
          
          result = Tor.determine_web_adversary_result(request, sender)
          
          return result if result[:error]
  
          Tor.emit_results(result[:message], nil, scene.room, false)
          
          {
          }
        end
      end
    end
  end