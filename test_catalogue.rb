require 'minitest/autorun'
require_relative 'catalogue'
 
class TestCatalogue < MiniTest::Test
  def setup
    @catalogue = Catalogue.new
    @product1 = Product.new 'product 1', 30, 12.99, 100
    @product2 = Product.new 'product 2', 90, 12.99, 100
    @product3 = Product.new 'product 3', 300, 12.99, 100 
    # ...... add more products if you wish .......
    # Put products into catalogue
    @catalogue.add_product @product1
    @catalogue.add_product @product2
    @catalogue.add_product @product3
  end

  def teardown
      @catalogue = @product1 = @product2 = @product3 = nil
  end
  
  def test_find_by_name
      # Normal
      assert_equal(@product1, @catalogue.find_product_by_name('product 1'))
      assert_nil( @catalogue.find_product_by_name('product X') )
   end

  def test_remove_by_name
       # Normal
       result = @catalogue.remove_product_by_name 'product 1'
       assert_equal @product1, result
       assert_nil( @catalogue.find_product_by_name('product 1'))
       assert_nil @catalogue.remove_product_by_name 'product X'
   end

  def test_check_reorder 
      # Normal
      result = @catalogue.check_reorder
      assert_equal 2, result.size
      assert_includes result, @product1
      assert_includes result, @product2
      product1.quantity = 120  # Quantity > Reorder
      product2.quantity = 110
      # ******To complete ********
      # Boundry
      @product1.quantity = 100
      result = @catalogue.check_reorder
      # ******To complete ********
  end

  def test_update_stock
        # Normal
        delivery = [['product 1',20],['product 3',30]]
        result = @catalogue.update_stock delivery
        # ******To complete ********
        # Error
        delivery = [['product 1',20],['product 3',30],['product 4',20]]
        result = @catalogue.update_stock delivery
        # ******To complete ********    
   end

   def test_discount
      # ******To complete ********
   end

end