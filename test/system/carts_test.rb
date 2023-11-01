require 'application_system_test_case'

class CartsTest < ApplicationSystemTestCase
  test 'should show and hide cart widget' do
    visit store_index_url

    click_on 'Add to Cart', match: :first

    assert has_content? 'Your Cart'

    click_on 'Empty Cart'

    assert has_no_content? 'Your Cart'
  end

  test 'should highlight feature' do
    visit store_index_url

    click_on 'Add to Cart', match: :first

    assert has_css? '.line-item-highlight'
  end
end
