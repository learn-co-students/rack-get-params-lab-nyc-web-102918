# Create a new class array called @@cart to hold any items in your cart
# We've provided the code for a basic list of items. Now it's your turn to extend it.

# Create a new route called /cart to show the items in your cart
# Create a new route called /add that takes in a GET param with the key item.
# This should check to see if that item is in @@items and then add it to the
# cart if it is. Otherwise give an error

class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.length == 0
        resp.write "Your cart is empty"
      else @@cart.each do |items|
        resp.write "#{items}\n"
      end
    end
    elsif req.path.match(/add/)
      add_item = req.params["item"]
        resp.write handle_add(add_item)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def handle_add(add_item)
    if @@items.include?(add_item)
      @@cart << add_item
      return "added #{add_item}"
    else
      return "We don't have that item"
    end
  end

end
