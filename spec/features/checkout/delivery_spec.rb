require "rails_helper"

RSpec.feature "CheckOut_delivery", :type => :feature do
  let(:user) {FactoryGirl.create(:user, :with_order)}

  before(:each) do
    login_as(user, scope: :user, run_callbacks: false)
    visit checkout_step_path(:delivery)
  end

  it "check delivery method" do
    expect(page.html).to have_content I18n.t('cart.order_summary')
    expect(page.html).to have_content I18n.t('cart.subtotal')
    expect(page.html).to have_content I18n.t('cart.ship')
    expect(page.html).to have_content I18n.t('cart.total')
    choose('shipping_method[id]', allow_label_click: true)
    click_button I18n.t('button.save_continue')
    expect(page.html).to have_content I18n.t('checkout.payment.title')
    expect(page.html).to have_content I18n.t('checkout.payment.number')
    expect(page.html).to have_content I18n.t('checkout.payment.cardname')
    expect(page.html).to have_content I18n.t('checkout.payment.expired')
    expect(page.html).to have_content I18n.t('checkout.payment.cvv')
  end
end
