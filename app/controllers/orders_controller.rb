class OrdersController < ApplicationController
    before_action :set_order, only: [:show]
    include ChessStoreHelpers::Shipping
    include ChessStoreHelpers::Cart
    def index
        @orders = Order.all.to_a
    end

    def new
        @order = Order.new
    end

    def edit
    end

    def show
        @order_history = @user.orders.chronological.to_a
    end

    def create
        @order=Order.new(order_params)
        @order.date=Date.current
        @order.user_id=session[:user_id]
        @order.expiration_month=@order.expiration_month.to_i
        @order.expiration_year=@order.expiration_year.to_i
        @order.grand_total=calculate_cart_items_cost+calculate_cart_shipping
        @order.pay
        if @order.save
            save_each_item_in_cart(@order)
            redirect_to home_path, notice: "Succesfully created the new order."
        else
            render action: "new"
        end
    end

    def update
        if @order.shipped_on.nil?
            if @order.update(order_params)
                redirect_to new_order_path
            else
                render action: 'edit'
            end
        end
    end

    def destroy
    end

        def order_history
            @orders = current_user.orders 
        end
    private
        def set_order
            @order = Order.find(params[:id])
        end

        def order_params
            params.require(:order).permit(:school_id,:credit_card_number,:expiration_month,:expiration_year,:user_id)
        end
    end







