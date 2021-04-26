class Merchant::BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = BulkDiscount.all
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @merchant.bulk_discounts.create!(
      discount_percentage: params[:bulk_discount][:discount_percentage],
      quantity: params[:bulk_discount][:quantity],
      merchant_id: @merchant.id)
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = merchant.bulk_discounts.destroy(params[:id])
    redirect_to merchant_bulk_discounts_path(merchant)
  end
end
