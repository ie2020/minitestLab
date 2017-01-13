class Catalogue  

   def initialize 
      @products = []
   end

   def add_product(product)
  	  @products << product
   end

   def find_product_by_name name
      @products.find { |p| p.name == name}
   end

   def remove_product_by_name name   
       product = find_product_by_name name
       @products.delete(product) if ! product.nil?
       product
   end
   
   # Return an array of products whose quantity is less than 
   # or equal to its reorder level 
   def check_reorder
       @products.select { |p|  p.quantity <= p.reorder_level}
   end

    # The 'delivery' argument represents the lines in an 
    # invoice and is coded as an array structure. Each line 
    # is also coded an array, with exactly two elements, a product 
    # name (string) and a quantity (integer), for example ['product X',20].
    # The method updates the catalogue with the details in the 
    # delivery array. It returns an array containing any lines 
    # with an invalid product name - mostly empty.
    def update_stock delivery
      mismatches = []
      delivery.each do |d|
          match = find_product_by_name d[0]
          if match
            match.quantity += d[1].to_i
          else
            mismatches << d 
          end
        end
        mismatches
    end

    # Apply a discount to those products that are overstocked, 
    # i.e. the quantity is a multiple (ratio) of its reorder level. 
    # The discount is expressed as a percentage (eg 10%). Return the 
    # number of products that had the discount applied.   
    def discount percentage, ratio
      matches = @products.select { |p| p.quantity > p.reorder_level*ratio.to_i }
      matches.each { |p|  p.price -= p.price * (percentage.to_i/100.0) }
      matches.size
    end
end 

class Product 
  attr_reader :name
  attr_accessor :quantity, :price, :reorder_level

  def initialize name, quantity, price, reorder_level
    @name = name
    @quantity = quantity
    @price = price
    @reorder_level = reorder_level
  end
  def to_s
      "#{@name} - #{@price}"
  end
end

