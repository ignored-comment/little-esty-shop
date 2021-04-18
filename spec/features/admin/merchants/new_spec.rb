require 'rails_helper'

RSpec.describe 'Admin Merchants New Page' do
  describe 'As an admin' do
    before :each do
      visit new_admin_merchant_path
    end
    it 'I am taken to a form that allows me to add merchant information' do

      within('#form') do
        fill_in('merchant_name', with: 'New Record')
        click_on 'Submit'
      end

      expect(current_path).to eq(admin_merchants_path)

      within('#disabled_merchants') do
        expect(page).to have_content('New Record')
      end

      expect(page).to have_content('Merchant Created Successfully')

    end

    it 'shows flash message if fields are saved blank' do

      within('#form') do
        fill_in('merchant_name', with: '')
        click_on 'Submit'
      end

      expect(page).to have_selector('.flash-message')
    end
  end
end
