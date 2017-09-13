require "rails_helper"

RSpec.feature "CheckOut_address", :type => :feature do
  let(:user) {FactoryGirl.create(:user)}
  let(:order) {FactoryGirl.create(:order)}

  before(:each) do
    FactoryGirl.create(:order_status)

    FactoryGirl.create(:book)
    FactoryGirl.create(:billing_address, user_id: user.id, order_id: order.id)
    FactoryGirl.create(:shipping_address, user_id: user.id, order_id: order.id)
    login_as(user, scope: :user, run_callbacks: false)
    visit root_path
  end

  describe "login user and clicks the Checkout button" do
    it "login user" do
      expect(page.html).to have_content "test@example.com"
      expect(page.html).to have_content I18n.t('header.log_out')
    end

    it "his order (empty cart)" do
      visit cart_path
      expect(page.html).to have_content I18n.t('cart.empty')
    end
    it "his order (not empty cart) valid address" do
      first(:button, 'Buy Now', minimum: 1).click
      visit cart_path
      first(:button, 'Checkout', minimum: 1).click
      expect(page.html).to have_content "Checkout"
      expect(page.html).to have_content "Billing Address"
      expect(page.html).to have_content "Shipping Address"
      bill = order.billing_address
      ship = order.shipping_address
      fill_in 'setting_address[billing_address][first_name]', with: bill.first_name
      fill_in 'setting_address[billing_address][last_name]', with: bill.last_name
      fill_in 'setting_address[billing_address][address]', with: bill.address
      fill_in 'setting_address[billing_address][city]', with: bill.city
      fill_in 'setting_address[billing_address][zip]', with: bill.zip
      fill_in 'setting_address[billing_address][phone]', with: bill.phone
      fill_in 'setting_address[shipping_address][first_name]', with: ship.first_name
      fill_in 'setting_address[shipping_address][last_name]', with: ship.last_name
      fill_in 'setting_address[shipping_address][address]', with: ship.address
      fill_in 'setting_address[shipping_address][city]', with: ship.city
      fill_in 'setting_address[shipping_address][zip]', with: ship.zip
      fill_in 'setting_address[shipping_address][phone]', with: ship.phone
      click_button I18n.t('button.save_continue')
      expect(page.html).to have_content "Shipping Method"
      expect(page.html).to have_content "Days"
    end

    it "his order (not empty cart) invalid address" do
      first(:button, 'Buy Now', minimum: 1).click
      visit cart_path
      first(:button, 'Checkout', minimum: 1).click
      expect(page.html).to have_content "Checkout"
      expect(page.html).to have_content "Billing Address"
      expect(page.html).to have_content "Shipping Address"
      bill = order.billing_address
      ship = order.shipping_address
      fill_in 'setting_address[billing_address][first_name]', with: ''
      fill_in 'setting_address[billing_address][last_name]', with: bill.last_name
      fill_in 'setting_address[billing_address][address]', with: bill.address
      fill_in 'setting_address[billing_address][city]', with: bill.city
      fill_in 'setting_address[billing_address][zip]', with: bill.zip
      fill_in 'setting_address[billing_address][phone]', with: bill.phone
      fill_in 'setting_address[shipping_address][first_name]', with: ship.first_name
      fill_in 'setting_address[shipping_address][last_name]', with: ship.last_name
      fill_in 'setting_address[shipping_address][address]', with: ship.address
      fill_in 'setting_address[shipping_address][city]', with: ship.city
      fill_in 'setting_address[shipping_address][zip]', with: ship.zip
      fill_in 'setting_address[shipping_address][phone]', with: ship.phone
      click_button I18n.t('button.save_continue')

      expect(page.html).to have_content "Checkout"
      expect(page.html).to have_content "Billing Address"
      expect(page.html).to have_content "Shipping Address"
      within('.has-error') do
        fill_in 'setting_address[billing_address][first_name]', with: 'Test'
      end
      click_button I18n.t('button.save_continue')
      expect(page.html).to have_content "Shipping Method"
      expect(page.html).to have_content "Days"
    end
  end

# Checkout complete
# On this page are placed:
# ‘Thank You for your Order!’ message:
# ‘An order confirmation email has been sent to [user email].’
# Shipping Address with attributes:
# First Name, Last Name, Address, City, Zip, Country, Phone.
# Order Number (R00000000), Date of order creation ( Month d, yyyy).
# List of added Products with attributes:
# Photo, Name, Description (first sentence), Price (€ 00.00), Quantity, Total.
# Order Summary with lines:
# Subtotal (€ 00.00), Coupon (€-00.00), Shipping (€ 00.00), Total (€ 00.00).
# Back to Store button.

# Given The  user is logged in
# And he is at the Checkout page, the Complete tab
# And the user can check all displayed information,
# Then the user can click the Back to Store button,
# And he will be transferred to the Catalog page.









end
