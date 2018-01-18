class HomeController < ApplicationController
  def home
    if current_user && current_user.role == "shipper"
        @shipper_list = OrderItem.all
    if current_user && current_user.role == "admin"
        @Sales_list = OrderItem.all
    if current_user && current_user.role == "customer"
      @orders = current_user.orders 
    end
    end      
  end
      @items_to_reorder = Item.need_reorder.alphabetical.to_a


  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end