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
  end
end
