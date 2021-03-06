class Api::V1::InvoiceItems::FindController < FindController
  def show
    render json: InvoiceItem.find_by(search_params)
  end

  def index
    render json: InvoiceItem.where(search_params)
  end

  private

  def search_params
    super.permit(:id,
                 :invoice_id,
                 :item_id,
                 :quantity,
                 :unit_price,
                 :created_at,
                 :updated_at)
  end
end
