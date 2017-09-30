require "rails_helper"

RSpec.feature "CheckOut_payment", :type => :feature do
  let(:user) {FactoryGirl.create(:user, :with_order)}

  before(:each) do
    login_as(user, scope: :user, run_callbacks: false)
    visit checkout_step_path(:payment)
    FactoryGirl.create(:order_status)
  end
  it "valid payment" do
    fill_in 'credit_card[number]', with: '12345678909876'
    fill_in 'credit_card[name]', with: 'Diana'
    fill_in 'credit_card[expired]', with: '11/22'
    fill_in 'credit_card[cvv]', with: '9764'
    click_button I18n.t('button.save_continue')
    expect(page.html).to have_content I18n.t('checkout.confirm.ship_address')
    expect(page.html).to have_content I18n.t('checkout.confirm.bil_address')
    expect(page.html).to have_content I18n.t('checkout.confirm.ship')
    expect(page.html).to have_content I18n.t('checkout.confirm.pay')
  end
  it "invalid payment" do
    fill_in 'credit_card[number]', with: ''
    fill_in 'credit_card[name]', with: 'Diana'
    fill_in 'credit_card[expired]', with: '11/22'
    fill_in 'credit_card[cvv]', with: '9764'
    click_button I18n.t('button.save_continue')
    within('.has-error') do
      fill_in 'credit_card[number]', with: '147852369852145'
    end
    click_button I18n.t('button.save_continue')
    expect(page.html).to have_content I18n.t('checkout.confirm.ship_address')
    expect(page.html).to have_content I18n.t('checkout.confirm.bil_address')
    expect(page.html).to have_content I18n.t('checkout.confirm.ship')
    expect(page.html).to have_content I18n.t('checkout.confirm.pay')
  end
end
