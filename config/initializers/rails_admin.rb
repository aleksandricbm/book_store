require Rails.root.join('lib', 'rails_admin', 'order_change_state.rb')
require Rails.root.join('lib', 'rails_admin', 'review_change_state.rb')

RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    # warden.authenticate! scope: :user
    redirect_to main_app.root_path unless current_user.admin?
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit do
      except ['Order', 'Review']
    end
    delete do
      except ['Order', 'Review']
    end
    show_in_app

    change_state do
      visible do
        bindings[:abstract_model].model.to_s == "Order"
      end
    end

    review_change_state do
      visible do
        bindings[:abstract_model].model.to_s == "Review"
      end
    end
  end

  config.included_models = ["Book", "Author", "Category", "Order", "Review"]

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

  config.model "Order" do
    list do
      field :number
      field :created_at
      field :order_status
      scopes [:processing, :delivered, :canceled]
    end
  end

  config.model "Review" do
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
      scopes [:unprocessed, :processed]
    end
    edit do
      field :check
    end
  end
end
