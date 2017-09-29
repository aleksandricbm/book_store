require Rails.root.join('lib', 'rails_admin', 'order_change_state.rb')
require Rails.root.join('lib', 'rails_admin', 'review_change_state.rb')

RailsAdmin.config do |config|
  ## == Devise ==
  config.authenticate_with do
    # warden.authenticate! scope: :user
    redirect_to main_app.user_session_path unless current_user && current_user.try(:admin?)
  end
  config.current_user_method(&:current_user)

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit do
      except %w[Order Review]
    end
    delete do
      except %w[Order Review]
    end
    show_in_app

    change_state do
      visible do
        bindings[:abstract_model].model.to_s == 'Order'
      end
    end

    review_change_state do
      visible do
        bindings[:abstract_model].model.to_s == 'Review'
      end
    end
  end

  config.included_models = %w[Book Author Category Order Review Image]

  config.model 'Image' do
    edit do
      field :file, :carrierwave
      include_all_fields
    end
  end
  config.model 'Book' do
    list do
      field :category
      field :name
      field :authors
      field :description do
        column_width 300
      end
      field :price
    end
    edit do
      include_all_fields
      field :description, :ck_editor
      field :category
      field :authors
    end
  end

  config.model 'Order' do
    list do
      field :number
      field :created_at
      field :order_status
      scopes %i[processing delivered canceled]
    end
  end

  config.model 'Review' do
    list do
      field :book
      field :comment
      field :created_at
      field :user do
        pretty_value do
          value.try(:first_name)
        end
      end
      field :check
      scopes %i[unprocessed processed]
    end
    edit do
      field :check
    end
  end
end
