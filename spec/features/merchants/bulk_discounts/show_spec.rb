require 'rails_helper'

RSpec.describe "BulkDiscount Show Page", type: :feature do
  before :each do
    @merchant1 = create(:merchant)
    @discount1 = @merchant1.bulk_discounts.create!(discount_percentage: 20.0, quantity: 10)
    visit merchant_bulk_discount_path(@merchant1, @discount1)
  end

  describe 'when I visit my bulk discount show page' do
    it "shows me the bulk discount's quantity threshold and percentage discount" do
      expect(page).to have_content(@discount1.discount_percentage)
      expect(page).to have_content(@discount1.quantity)
    end

    it 'has a link for me to edit this discount' do
      expect(page).to have_link("Edit this discount")
    end

    it 'when I click this link, it takes me to a new page with a form to edit the discount' do
      click_on "Edit this discount"

      expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @discount1))
    end
  end
end
