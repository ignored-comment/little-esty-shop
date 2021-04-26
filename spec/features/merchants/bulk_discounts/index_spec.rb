require 'rails_helper'

RSpec.describe 'Merchant BulkDiscounts Index' do
  before :each do
    @merchant1 = create(:merchant)
    @discount1 = @merchant1.bulk_discounts.create!(discount_percentage: 20.0, quantity: 10)
    @discount2 = @merchant1.bulk_discounts.create!(discount_percentage: 50.0, quantity: 65)

    @item1 = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)

    @customer1 = create(:customer)
    @invoice1 = create(:invoice, customer_id: @customer1.id, status: 2, created_at: "2019-03-20 09:54:09 UTC")
    @invoice2 = create(:invoice, customer_id: @customer1.id, status: 2, created_at: "2011-04-25 09:54:09 UTC")
    @invoice3 = create(:invoice, customer_id: @customer1.id, status: 2, created_at: "2018-08-01 09:54:09 UTC")
    @invoice4 = create(:invoice, customer_id: @customer1.id, status: 2, created_at: "2020-07-01 09:54:09 UTC")

    @invoice_items1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, status: 1)
    @invoice_items2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice2.id, status: 1)
    @invoice_items4 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice4.id, status: 1)

    visit merchant_bulk_discounts_path(@merchant1)
  end

  describe 'when I visit the discounts index page' do
    it 'shows me a list of all discounts, with each discount showing me percentage and quantity' do
      expect(page).to have_content(@discount1.discount_percentage)
      expect(page).to have_content(@discount1.quantity)
      expect(page).to have_content(@discount2.discount_percentage)
      expect(page).to have_content(@discount2.quantity)
    end

    it 'shows me a section with a header of Upcoming Holidays' do
      expect(page).to have_content("Upcoming Holidays")
    end

    it 'has a link to allow me to create a new discount' do
      expect(page).to have_link("Create a New Discount")
    end

    it 'allows me to click on creating a new discount to take me to the new discount page' do
      click_link "Create a New Discount"
      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
    end

    it 'when I fill in this form with valid data, I am then redirected back to the bulk discount index and I see my new discount listed' do
      click_link "Create a New Discount"

      fill_in "Discount percentage", with: "99"
      fill_in "Quantity", with: "99"

      click_button "Create Bulk discount"

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
    end
  end
end
