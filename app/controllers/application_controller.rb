class ApplicationController < ActionController::Base

    def action_missing(m, *args, &block)
		flash[:error] = "Unauthorized to access."
		redirect_to :root and return
    end

end
