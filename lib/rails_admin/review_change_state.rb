require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdminReviewChangeStateAction; end

module RailsAdmin
  module Config
    module Actions
      class ReviewChangeState < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :member? do
          true
        end

        register_instance_option :route_fragment do
          'review_change_state'
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
              Review.find(params[:id]).update_attribute(:check, 1) if params[:commit] == 'Approve'
              Review.find(params[:id]).update_attribute(:check, 2) if params[:commit] == 'Reject'
              flash.now[:notice] = "Review change state successful"
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
