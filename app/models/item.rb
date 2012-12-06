require 'open-uri'

class Item < ActiveRecord::Base
  attr_accessible :code, :title, :description, :price, :image_url
  
  def uri
    "https://www.googleapis.com/shopping/search/v1/public/products?key=#{google_api_key}&country=US&restrictBy=gtin:#{code}&alt=json"
  end
  
  def google_api_key
    'AIzaSyCsx-82UroO6qDlhQE8FlsO768DU7R29zw'
  end
  
  def google_api
    @json_feed ||= ActiveSupport::JSON.decode(open(uri))
  end
  
  def google_name
    google_api["items"].first["product"]["title"]
  end
  
  def google_description
    google_api["items"].first["product"]["description"]
  end
  
  def google_price
    google_api["items"].first["product"]["inventories"].first["price"]
  end
  
  def google_image_url
    google_api["items"].first["product"]["images"].first["link"]
  end
  
  def update_item_info
    self.title = google_name
    self.description = google_description
    self.price = google_price
    self.image_url = google_image_url
    self.save
  end
  
end
