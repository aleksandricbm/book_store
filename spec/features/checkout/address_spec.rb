require 'rails_helper'

RSpec.feature 'CheckOut_address', :type => :feature do
  let(:user) {FactoryGirl.create(:user)}

  before(:each) do
    FactoryGirl.create(:book)
    login_as(user, scope: :user, run_callbacks: false)
    visit root_path
    FactoryGirl.create(:shipping_method)
  end

  describe 'login user and clicks the Checkout button' do
    it 'login user' do
      expect(page.html).to have_content 'test@example.com'
      expect(page.html).to have_content I18n.t('header.log_out')
    end

    it 'his order (empty cart)' do
      visit cart_path
      expect(page.html).to have_content I18n.t('cart.empty')
    end
    it 'his order (not empty cart) valid address' do
      first(:button, 'Buy Now', minimum: 1).click
      visit cart_path
      first(:button, 'Checkout', minimum: 1).click
      expect(page.html).to have_content 'Checkout'
      expect(page.html).to have_content 'Billing Address'
      expect(page.html).to have_content 'Shipping Address'
      fill_in 'setting_address[billing_address][first_name]', with: 'firstname'
      fill_in 'setting_address[billing_address][last_name]', with: 'lastname'
      fill_in 'setting_address[billing_address][address]', with: 'address'
      fill_in 'setting_address[billing_address][city]', with: 'city'
      fill_in 'setting_address[billing_address][zip]', with: '5555'
      fill_in 'setting_address[billing_address][phone]', with: '76545575'
      fill_in 'setting_address[shipping_address][first_name]', with: 'firstname'
      fill_in 'setting_address[shipping_address][last_name]', with: 'lastname'
      fill_in 'setting_address[shipping_address][address]', with: 'address'
      fill_in 'setting_address[shipping_address][city]', with: 'city'
      fill_in 'setting_address[shipping_address][zip]', with: '6666'
      fill_in 'setting_address[shipping_address][phone]', with: '887765554'
      click_button I18n.t('button.save_continue')
      expect(page.html).to have_content 'Shipping Method'
      expect(page.html).to have_content 'Days'
    end

    it 'his order (not empty cart) invalid address' do
      first(:button, 'Buy Now', minimum: 1).click
      visit cart_path
      first(:button, 'Checkout', minimum: 1).click
      expect(page.html).to have_content 'Checkout'
      expect(page.html).to have_content 'Billing Address'
      expect(page.html).to have_content 'Shipping Address'

      click_button I18n.t('button.save_continue')

      expect(page.html).to have_content 'Checkout'
      expect(page.html).to have_content 'Billing Address'
      expect(page.html).to have_content 'Shipping Address'
      fill_in 'setting_address[billing_address][first_name]', with: 'Test'
      fill_in 'setting_address[billing_address][last_name]', with: 'lastname'
      fill_in 'setting_address[billing_address][address]', with: 'address'
      fill_in 'setting_address[billing_address][city]', with: 'city'
      fill_in 'setting_address[billing_address][zip]', with: '5555'
      fill_in 'setting_address[billing_address][phone]', with: '76545575'
      fill_in 'setting_address[shipping_address][first_name]', with: 'firstname'
      fill_in 'setting_address[shipping_address][last_name]', with: 'lastname'
      fill_in 'setting_address[shipping_address][address]', with: 'address'
      fill_in 'setting_address[shipping_address][city]', with: 'city'
      fill_in 'setting_address[shipping_address][zip]', with: '6666'
      fill_in 'setting_address[shipping_address][phone]', with: '887765554'
      click_button I18n.t('button.save_continue')
      expect(page.html).to have_content 'Shipping Method'
      expect(page.html).to have_content 'Days'
    end
  end
end
