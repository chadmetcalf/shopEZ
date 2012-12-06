class Item < ActiveRecord::Base
  attr_accessor :code, :title, :description, :price, :image_url
  
  def uri
    "https://www.googleapis.com/shopping/search/v1/public/products?key=#{google_api_key}&country=US&restrictBy=gtin:#{code}&alt=json"
  end
  
  def google_api_key
    'AIzaSyCsx-82UroO6qDlhQE8FlsO768DU7R29zw'
  end
  
  def google_api
    @json_feed ||= ActiveSupport::JSON.decode(open(uri))
  end
  
  def product_name
    google_api["items"].first["product"]["title"]
  end
  
  def product_description
    google_api["items"].first["product"]["description"]
  end
  
  def product_price
    google_api["items"].first["product"]["inventories"].first["price"]
  end
  
  def product_image_url
    google_api["items"].first["product"]["images"].first["link"]
  end
  
end
