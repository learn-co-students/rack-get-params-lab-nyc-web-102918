class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)#if you're looking for the items
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)#if you're searching for one item
      search_term = req.params["q"]
      resp.write handle_search(search_term)#call method to search
    elsif req.path.match(/cart/) #if you're looking for what's in your cart
      if @@cart.empty?
        resp.write "Your cart is empty."
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    elsif req.path.match(/add/)#if you're trying to add something to your cart
      item_to_add = req.params["item"]
      if @@items.include?(item_to_add)
        @@cart << item_to_add
        resp.write "added #{item_to_add}"
      else
        resp.write "We don't have that item"
      end
    else
      resp.write "Path Not Found"
    end #if elsif else

    resp.finish
  end #def call(env)

  def handle_search
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end #def handle_search

end #class Application
