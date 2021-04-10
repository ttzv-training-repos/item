class SentItemsController < ApplicationController
 
  def index
    sentItemGroups = SentItemGroup.all
    data = sentItemGroups.map do |group|
      sent_items = group.sent_items
      if sent_items.first
        type = sent_items.first.item_type
      else
        type = "nil"
      end
      {
        length: sent_items.length,
        date: group.created_at,
        type: type,
        items: sent_items.map do |item|
            {
              id: item.id,
              title: item.title,
              status: item.status ? "Success" : "Error",
              status_content: item.status_content
            }
          end       
        }
    end
    render :json => {
      data: data
    }
  end

  def show
    id = params[:id]
    sent_item = SentItem.find(id);
    data = ""
    data = sent_item.as_json if sent_item
    render :json => {
      data: data
    }
  end

end
