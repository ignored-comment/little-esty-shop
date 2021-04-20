require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:merchants).through(:items) }
  end

  describe 'instance methods' do
    describe '#full_name' do
      it 'returns full name of customer' do
        customer_1 = create(:customer, first_name: "Spring", last_name: "Flowers")

        expect(customer_1.full_name).to eq("Spring Flowers")
      end
    end

    describe '#top_merchants' do
      before :each do
        @merchant1 = create(:merchant, status: true)
        @merchant2 = create(:merchant, status: true)
        @merchant3 = create(:merchant, status: false)
        @merchant4 = create(:merchant, status: false)
        @merchant5 = create(:merchant, status: false)
        @merchant6 = create(:merchant, status: true)

        @item1 = create(:item, merchant_id: @merchant1.id)
        @item2 = create(:item, merchant_id: @merchant2.id)
        @item3 = create(:item, merchant_id: @merchant3.id)
        @item4 = create(:item, merchant_id: @merchant4.id)
        @item5 = create(:item, merchant_id: @merchant5.id)
        @item6 = create(:item, merchant_id: @merchant6.id)

        @invoice1 = create(:invoice)
        @invoice2 = create(:invoice)
        @invoice3 = create(:invoice)
        @invoice4 = create(:invoice)
        @invoice5 = create(:invoice)
        @invoice6 = create(:invoice)

        @invoice_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id, status: 1, quantity: 5, unit_price: 100)
        @invoice_item2 = create(:invoice_item, invoice_id: @invoice2.id, item_id: @item2.id, status: 1, quantity: 15, unit_price: 100)
        @invoice_item3 = create(:invoice_item, invoice_id: @invoice3.id, item_id: @item3.id, status: 0, quantity: 9, unit_price: 100)
        @invoice_item4 = create(:invoice_item, invoice_id: @invoice4.id, item_id: @item4.id, status: 2, quantity: 10, unit_price: 100)
        @invoice_item5 = create(:invoice_item, invoice_id: @invoice5.id, item_id: @item5.id, status: 0, quantity: 2, unit_price: 100)
        @invoice_item6 = create(:invoice_item, invoice_id: @invoice6.id, item_id: @item6.id, status: 2, quantity: 11, unit_price: 100)

        @transactions = create_list(:transaction, 6, invoice_id: @invoice_item1.invoice.id, result: 0)
        @transactions2 = create_list(:transaction, 7, invoice_id: @invoice_item2.invoice.id, result: 1)
        @transactions3 = create_list(:transaction, 8, invoice_id: @invoice_item3.invoice.id, result: 0)
        @transactions4 = create_list(:transaction, 9, invoice_id: @invoice_item4.invoice.id, result: 1)
        @transactions5 = create_list(:transaction, 10, invoice_id: @invoice_item5.invoice.id, result: 0)
        @transactions6 = create_list(:transaction, 11, invoice_id: @invoice_item6.invoice.id, result: 1)

      end
      it 'returns 5 merchants with successful transactions and ordered by most money spent on them' do

      end
    end
  end
end
