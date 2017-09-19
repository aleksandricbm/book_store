require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdminChangeStateAction; end

module RailsAdmin
  module Config
    module Actions
      class ChangeState < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :member? do
          true
        end

        register_instance_option :route_fragment do
          'change_state'
        end

        register_instance_option :http_methods do
          %i(get put)
        end

        register_instance_option :visible? do
          true
        end

        register_instance_option :controller do
          proc do
            if request.get?
              render @action.template_name, layout: false
            else
              flash.now[:notice] = "Change state successful" if Order.find(params[:id]).update_attribute(:order_status_id, params[:order][:order_status_id])
              redirect_to back_or_index
            end
          end
        end

        register_instance_option :link_icon do
          'icon-pencil'
        end
      end
    end
  end
end
