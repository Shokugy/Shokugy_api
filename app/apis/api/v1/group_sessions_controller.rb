module API
  module V1
    class GroupSessionsController < API::V1::ApplicationBaseController
      skip_before_filter :require_valid_token, only: :create

      def create
        login_group
        unless @group
          @error_message = 'login failed'
          return
        end
        current_user.update(active_group_id: @group.id)
        unless @group.users.ids.include?(current_user.id)
          @group.users.each do |user|
            user.notifications.create(content: "#{current_user.name}さんが#{@group.name}に参加しました。")
          end
          @group.users << current_user
        end
      end

      def destroy
        access_token = request.headers[:HTTP_ACCESS_TOKEN]
        api_key = ApiKey.find_by_access_token(access_token)
        if api_key
          user = User.find(api_key.user_id)
          user.inactivate
          respond_to do |format|
            format.json { render nothing: true, status: :ok }
          end
        end
      end

      private
      def login_group
        @group = login(login_params)
      end

      def login_user
        params[:user]
      end

      def login_params
        params.permit(:name).merge(password: request.headers["Password"])
      end

    end
  end
end
