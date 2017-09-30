require "rails_helper"

RSpec.feature "CheckOut_confirm", :type => :feature do
  let(:user) {FactoryGirl.create(:user, :with_order)}
  FactoryGirl.create(:order_status)

  before(:each) do
    login_as(user, scope: :user, run_callbacks: false)
    visit checkout_step_path(:confirm)

  end

  it "check all data" do
    expect(page.html).to have_content I18n.t('checkout.confirm.ship_address')
    expect(page.html).to have_content I18n.t('checkout.confirm.bil_address')
    expect(page.html).to have_content I18n.t('checkout.confirm.ship')
    expect(page.html).to have_content I18n.t('checkout.confirm.pay')
    @order = user.orders.last
    ship = @order.shipping_address
    bill = @order.billing_address
    delivery = @order.shipping_method
    credit = @order.credit_card
    order_item = @order.order_items.last
    book_order = order_item.book
    expect(page.html).to have_content ship.first_name
    expect(page.html).to have_content ship.last_name
    expect(page.html).to have_content ship.address
    expect(page.html).to have_content ship.city
    expect(page.html).to have_content ship.zip
    expect(page.html).to have_content ship.phone

    expect(page.html).to have_content bill.first_name
    expect(page.html).to have_content bill.last_name
    expect(page.html).to have_content bill.address
    expect(page.html).to have_content bill.city
    expect(page.html).to have_content bill.zip
    expect(page.html).to have_content bill.phone

    expect(page.html).to have_content delivery.name
    expect(page.html).to have_content "€ #{delivery.price}"

    expect(page.html).to have_content "** ** ** #{credit.number.to_s[-4,4]}"
    expect(page.html).to have_content credit.expired

    expect(page.html).to have_content book_order.name
    expect(page.html).to have_content book_order.description
    expect(page.html).to have_content order_item.price
    expect(page.html).to have_content order_item.quantity
    expect(page.html).to have_content order_item.quantity*order_item.price

    expect(page.html).to have_content I18n.t('cart.order_summary')
    expect(page.html).to have_content I18n.t('cart.subtotal')
    expect(page.html).to have_content I18n.t('cart.ship')
    expect(page.html).to have_content I18n.t('cart.total')
    click_button I18n.t('button.place_order')
    expect(page).to have_current_path('/checkout_steps/complete')
  end

  it "redirect to checkout address" do

    first(:link, 'edit').click
    expect(page).to have_selector("h3.general-subtitle", text: I18n.t("settings.s_address"))
    expect(page).to have_selector("h3.general-subtitle", text: I18n.t("settings.b_address"))
    click_button I18n.t('button.save_continue')
    expect(page).to have_current_path('/checkout_steps/confirm')
  end

  it "redirect to checkout payments" do
    find_link(href: /payment/).click
    expect(page).to have_selector("h3.general-subtitle", text: I18n.t('checkout.payment.title'))
    click_button I18n.t('button.save_continue')
    expect(page).to have_current_path('/checkout_steps/confirm')
  end

  it "redirect to checkout delivery" do
    find_link(href: /delivery/).click
    expect(page).to have_selector("h3.general-subtitle", text: I18n.t('checkout.ship_method'))
    click_button I18n.t('button.save_continue')
    expect(page).to have_current_path('/checkout_steps/confirm')
  end
end
