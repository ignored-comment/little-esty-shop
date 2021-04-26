require 'rails_helper'

RSpec.describe "BulkDiscount Edit Page", type: :feature do
  before :each do
    @merchant1 = create(:merchant)
    @discount1 = @merchant1.bulk_discounts.create!(discount_percentage: 20.0, quantity: 10)
    visit edit_merchant_bulk_discount_path(@merchant1, @discount1)
  end

  describe 'when I visit the merchant bulk edit page' do
    it 'allows me to edit the discount and return me to the discount show page' do
      fill_in "Discount percentage", with: "55.5"
      fill_in "Quantity", with: "55"

      click_on "Update Bulk discount"

      expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @discount1))
      expect(page).to have_content("55.5")
      expect(page).to have_content("55")
    end
  end
end
