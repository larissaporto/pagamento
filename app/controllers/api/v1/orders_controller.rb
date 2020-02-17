module Api
  module V1
    class OrdersController < ApiController
      def create
        client = ClientProfile.find_by(auth_token: params[:client_token])
        if client.nil?
          render json: { "message": 'Cliente não registrado' },
                 status: :precondition_failed
          return
        end
        order = client.orders.new(order_params)
        if order.valid?
          order.save!
          render json: { order: order, client: order.client,
                         payment_method: order.payment_method },
                 status: :created
        else
          render json: { "message": order.errors.full_messages },
                 status: :precondition_failed
        end
      end

      private
      
      def order_params
        params.permit(:client_token, :order_id, :order_value,
                      :payment_method_id)
      end
    end
  end
end