class Merchant::InvoiceItemsController < ApplicationController
  def update
    binding.pry
    @invoice_item.update!(item_params)
    flash[:success] = "Item successfully updated"
    redirect_to merchant_invoice_path(params[:merchant_id], @invoice_item.invoice_id)
  end
  #
  # private
  #
  def item_params
    params.require(:invoice_item).permit(:status)
  end
end
