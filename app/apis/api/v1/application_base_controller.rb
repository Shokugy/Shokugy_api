module API
  module V1
    class ApplicationBaseController < ApplicationController
      # before_action :require_valid_token

      helpers do
        def current_user
          if request.headers["Fb-Id"]
            @current_user ||= User.find_by(fb_id: request.headers["Fb-Id"])
          end
          return @current_user
        end
      end

      private

      def require_valid_token
        access_token = request.headers[:HTTP_ACCESS_TOKEN]
        if !User.login?(access_token)
          respond_to do |format|
            format.json { render nothing: true, status: :unauthorized }
          end
        end
      end
    end
  end
end
