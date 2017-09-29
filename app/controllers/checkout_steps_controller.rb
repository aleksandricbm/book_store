# This class CheckoutStepsController
class CheckoutStepsController < ApplicationController

  include Wicked::Wizard
  steps :login, :address, :delivery, :payment, :confirm, :complete

  include StepCheckoutShow
  include StepCheckoutUpdate

  def show
    return redirect_to cart_path if current_order.order_items.count < 1
    @order = current_order
    session[:checkout] = :checkout
    @step = :login unless user_signed_in?
    step_jump(step)
    render_wizard
  end

  def update
    case step
    when :address then update_address
    when :delivery then update_delivery
    when :payment then update_payment
    when :complete then update_complete
    end
  end

  private

  def redirect_steps
    return redirect_to wizard_path(params[:redirect]) if params[:redirect].present? && (params[:redirect] == 'confirm' || params[:redirect] == 'complete')
    redirect_to next_wizard_path
  end

end
