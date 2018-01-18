class ItemPricesController < ApplicationController
    before_action :check_login
    authorize_resource

  def index
    @active_items = Item.active.alphabetical.to_a
  end

  def new
    puts "item price controller -- new entered"
    @item_price = ItemPrice.new
    # @item = Item.find_by_id(params[:item_id])
    # respond_to do |format|
    #   format.html
    #   format.js { render 'items/new_item_price.js.erb'}
    # end
  end

  # def show
  # end

  def create
    puts "item price controller -- create entered"
    @item_price = ItemPrice.new(item_price_params)
    @item_price.start_date = Date.current
    
      if @item_price.save        
        respond_to do |format|
          @item = @item_price.item
          format.html { redirect_to item_path(@item), notice: "Changed the price of #{@item.name}." }
          @price_history = @item_price.item.item_prices.chronological.to_a
          @w_price_history = @item_price.item.item_prices.wholesale.chronological.to_a
          @m_price_history = @item_price.item.item_prices.manufacturer.chronological.to_a
          # format.js { render '/items/true_item_price.js.erb'}
          format.js
          puts "----------------------------------------------------------------how did i get here"
        end

      else
          puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!SORRY YOU FAILED AGAIN"
          format.html { render action: 'new' }
          format.js
      end
  end

  private
  # def set_item_price
  #   @item_price = ItemPrice.find(params[:id])
  # end
  def item_price_params
    params.require(:item_price).permit(:item_id, :price, :category)
  end
  
end