module AresMUSH
  module Plugin

    def initialize
      # Reserved for common plugin init
      after_initialize
    end
            
    # Override this with any custom initialization
    def after_initialize
    end
    
    attr_accessor :client, :cmd
    
    # Override this with the processing needed to tell if you want a particular command
    # *from a char who is logged in*.
    #
    # You can do basic operations:
    #    cmd.raw.start_with?(":")
    #
    # Or use some of the handy helper methods:
    #    cmd.root_is?("finger")
    #    cmd.logged_in?
    #
    # You can even do more complex and/or combinations.
    def want_command?(cmd)
      false
    end    

    # This defines basic processing suitable for many commands.  You can override this 
    # method entirely if you need advanced processing, or just override the helper methods
    # as needed.  See the documentation on crack!, validate and handle for more info.
    def on_command(client, cmd)
      @client = client
      @cmd = cmd
      crack!
      error = validate
      if (error)
        client.emit_failure(error)
        return
      end
      handle
    end
    
    # Override this to perform any advanced argument processing.  For example, if your 
    # command is in the form foo/bar arg1=arg2, you can split up arg1 and arg2 easily by 
    # doing:
    #    def crack!
    #       @cmd.crack!(/(?<arg1>[^\=]+)=(?<arg2>.+)/)
    #    end
    # After that, you will be able to access your command arguments by name by doing:
    #      @cmd.args.arg1  or  @cmd.args.arg2
    def crack!
    end

    # Override this for any preliminary error checking for your command.  Return an error string
    # (remember to translate!) or nil if there are no errors.
    # For example, to restrict the command to only logged in players, you can do:
    #    def validate
    #     return t(dispatcher.must_be_logged_in) if !@cmd.logged_in?
    #     return nil
    #   end
    def validate
      return nil
    end
    
    # Override this with the details of your command handling.
    def handle
      Global.logger.warn("#{self} said it wanted a command and didn't handle it!")
    end    
 
    # Override this if you don't want logging at all, or don't want to log the full command - 
    # for instance to avoid logging a connect command for privacy of passwords.
    def log_command(client, cmd)
      Global.logger.debug("#{self.class.name}: #{cmd} from #{client}")
    end
  end
end