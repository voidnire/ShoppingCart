require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  # ----------------------- GET TESTS -------------------------
  test "should get product by id" do
    get product_url(@product), as: :json
    puts ""
    puts ""
    puts "GET-PRODUCT-TEST: should get product by id"
    puts "Response Status: #{response.status}"
    puts "Response Body: #{response.body}"

    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal @product.id, json_response["id"]
    assert_equal @product.name, json_response["name"]
    assert_equal @product.price.to_s, json_response["price"].to_s
    puts ""
    puts ""
  end

  test "should return 404 when product not found" do
    get product_url(id: 999999)
    puts ""
    puts ""
    puts "GET-PRODUCT-TEST: should return 404 when product not found"
    puts response.body #retorno da API

    assert_response :not_found
    json_response = JSON.parse(response.body)
    assert_match /Produto não encontrado/, json_response["error"]
    puts ""
    puts ""
  end

  # ----------------------- POST TESTS -------------------------
  test "should create product" do
    product_params = { product: { name: "New Product", price: 15.99 } }
    puts ""
    puts ""
    puts "POST-PRODUCT-TEST: should create product"

    assert_difference("Product.count", 1) do
      post products_url, params: product_params, as: :json
    end

    assert_response :created
    json_response = JSON.parse(response.body)

    puts "Response Body: #{response.body}" # Debugging output

    assert_equal "New Product", json_response["name"]
    assert_equal "15.99", json_response["price"].to_s
    puts ""
    puts ""
  end

  test "should not create product with invalid data" do
    puts ""
    puts "POST-PRODUCT-TEST: should not create product with invalid data"

    product_params = { product: { name: "", price: -22 } }

    assert_no_difference("Product.count") do
      post products_url, params: product_params, as: :json
    end

    assert_response :unprocessable_entity
    json_response = JSON.parse(response.body)

    puts "Error Response: #{response.body}" # Debugging output

    assert_includes json_response["name"], "can't be blank"
    assert_includes json_response["price"], "must be greater than or equal to 0"
    puts ""
  end

  # ----------------------- PATCH/PUT TESTS -------------------------
  test "should update product" do
    puts ""
    puts ""
    puts "PATCH/PUT-PRODUCT-TEST: should update product"

    update_params = { product: { name: "Updated Product", price: 19.99 } }

    patch product_url(@product), params: update_params, as: :json

    assert_response :success
    json_response = JSON.parse(response.body)

    puts "PATCH Response Body: #{response.body}" # Debugging output

    assert_equal "Updated Product", json_response["name"]
    assert_equal "19.99", json_response["price"].to_s
    puts ""
    puts ""
  end

  test "should not update product with invalid data" do
    puts ""
    puts ""
    puts "PATCH/PUT-PRODUCT-TEST: should not update product with invalid data"

    invalid_params = { product: { name: "", price: -5 } }

    patch product_url(@product), params: invalid_params, as: :json

    assert_response :unprocessable_entity
    json_response = JSON.parse(response.body)

    puts "PATCH Error Response: #{response.body}" # Debugging output

    assert_includes json_response["name"], "can't be blank"
    assert_includes json_response["price"], "must be greater than or equal to 0"
    puts ""
    puts ""
  end

  test "should return 404 when updating non-existing product" do
    puts ""
    puts ""
    puts "PATCH/PUT-PRODUCT-TEST: should return 404 when updating non-existing product"

    update_params = { product: { name: "Non-existing", price: 10 } }

    patch product_url(id: 999999), params: update_params, as: :json

    assert_response :not_found
    json_response = JSON.parse(response.body)

    puts "PATCH 404 Response: #{response.body}" # Debugging output

    assert_match /Produto não encontrado/, json_response["error"]
    puts ""
    puts ""
  end

  # ----------------------- PATCH/PUT TESTS -------------------------

  test "should delete product" do
    puts ""
    puts ""
    puts "DELETE-PRODUCT-TEST: should delete product"

    assert_difference("Product.count", -1) do
      delete product_url(@product), as: :json
    end

    assert_response :no_content
    puts ""
    puts ""
  end

  test "should return 404 when deleting non-existing product" do
    puts ""
    puts ""
    puts "DELETE-PRODUCT-TEST: should return 404 when deleting non-existing product"
    delete product_url(id: 999999), as: :json

    assert_response :not_found
    json_response = JSON.parse(response.body)

    puts "DELETE 404 Response: #{response.body}" # Debugging output

    assert_match /Produto não encontrado/, json_response["error"]
    puts ""
    puts ""
  end
end
