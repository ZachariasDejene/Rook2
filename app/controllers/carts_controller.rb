class CartsController < ApplicationController
    include ChessStoreHelpers::Cart

        def create
            if current_user.nil?
                redirect_to login_url, alert: "You need to log in to view this page."
            else
                create_cart 
            end
        end

        def index
            if current_user.nil?
                redirect_to login_url, alert: "You need to log in to view this page."
            else
                @items = get_list_of_items_in_cart
            end
        end

        def show
        end

        def edit
        end

        def update
        end

        def destroy
        end 

        def add_to_cart
            @item = Item.find(params[:id])
            if current_user.nil?
                redirect_to login_url, alert: "You need to log in to view this page."
            else
                add_item_to_cart(@item.id.to_s)
            end
            redirect_to show_cart_path, alert: "Added #{@item.name} to your cart!"
        end

        def remove_from_cart
            @item = Item.find(params[:id])
            if current_user.nil?
                redirect_to login_url, alert: "You need to log in to view this page."
            else
                remove_item_from_cart(@item.id.to_s)
            end
            redirect_to show_cart_path, alert: "Removed #{@item.name} to your cart!"

        end

        def dump_cart
            if current_user.nil?
                redirect_to login_url, alert: "You need to log in to view this page."
            else
                clear_cart
            end
            redirect_to show_cart_path, alert: "Emptied your cart!"
        end

    end

