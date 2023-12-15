require 'application_system_test_case'

class OrdersTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper
  include ActionMailer::TestHelper

  test 'check dynamic fields' do
    visit store_index_url

    click_on 'Add to Cart', match: :first

    click_on 'Checkout'

    assert has_no_field?('Routing number')
    assert has_no_field?('Account number')
    assert has_no_field?('Credit card number')
    assert has_no_field?('Expiration date')
    assert has_no_field?('Po number')

    select 'Check', from: 'Pay type'

    assert has_field?('Routing number')
    assert has_field?('Account number')
    assert has_no_field?('Credit card number')
    assert has_no_field?('Expiration date')
    assert has_no_field?('Po number')

    select 'Credit card', from: 'Pay type'

    assert has_no_field?('Routing number')
    assert has_no_field?('Account number')
    assert has_field?('Credit card number')
    assert has_field?('Expiration date')
    assert has_no_field?('Po number')

    select 'Purchase order', from: 'Pay type'

    assert has_no_field?('Routing number')
    assert has_no_field?('Account number')
    assert has_no_field?('Credit card number')
    assert has_no_field?('Expiration date')
    assert has_field?('Po number')
  end

  test 'check order and delivery' do
    LineItem.delete_all
    Order.delete_all

    visit store_index_url

    click_on 'Add to Cart', match: :first

    click_on 'Checkout'

    fill_in 'Name', with: 'Oleg'
    fill_in 'Address', with: 'Black sea Batumi'
    fill_in 'Email', with: 'oleg@test.com'

    select 'Check', from: 'Pay type'
    fill_in 'Routing number', with: '123456'
    fill_in 'Account number', with: '987654'

    click_button 'Place Order'
    assert_text 'Thank you for your order'

    perform_enqueued_jobs
    perform_enqueued_jobs
    # assert_enqueued_jobs 2

    orders = Order.all
    assert_equal 1, orders.size

    order = Order.first

    assert_equal 'Oleg', order.name
    assert_equal 'Black sea Batumi', order.address
    assert_equal 'oleg@test.com', order.email
    assert_equal 'Check', order.pay_type
    assert_equal 1, order.line_items.size

    mail = ActionMailer::Base.deliveries.last

    # assert_equal ["oleg@test.com"], mail.to
    # assert_equal 'Sam Ruby <depot@example.com>', mail[:from].value
    # assert_equal 'Depot Store Order Confirmation', mail.subject
  end
end
