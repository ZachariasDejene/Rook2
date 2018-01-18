class OrderItemsController < ApplicationController
    include ChessStoreHelpers::Cart
    include ChessStoreHelpers::Shipping

    authorize_resource
    before_action :set_o_item, only: [:is_shipped]

    def index
        @order_items = OrderItem.unshipped
    end

    # def new
    #     @order_item = OrderItem.new
    # end

    # def edit
    # end

    def show
    end

    # def create
    # end

    # def update
    #     if @order_item.unshipped
    #         if @order_item.update(order_params)
    #             redirect_to new_order_path
    #         else
    #             render action "edit"
    #         end
    #     end
    # end

    # def destroy
    #     if @order_item.unshipped
    #         @order_item.destroy
    #     end
    # end

    def is_shipped
        @o_item.shipped
        @shipper_list = OrderItem.unshipped.to_a
        puts(@o_item)
        respond_to do |format|
            format.html {redirect_to ship_path}
            format.js
        end       
    end

    def set_o_item
        @o_item = OrderItem.find(params[:id])
    end
end
