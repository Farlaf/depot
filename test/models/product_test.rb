# frozen_string_literal: true

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test 'product attributes mist not be empty' do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end

  test 'product price must be positive' do
    product = Product.new(
      title: 'My Book Title',
      description: 'yyy',
      image_url: 'zzz.jpg',
    )
    product.price = -1
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(
      title: 'My Book Title',
      description: 'yyy',
      price: 1,
      image_url:,
    )
  end

  test 'image url' do
    ok = ['fred.gif', 'fred.jpg', 'fred.png', 'FRED.JPG', 'FRED.Jpg', 'http://a.b.c/x/y/z/fred.gif']
    bad = ['fred.doc', 'fred.gif/more', 'fred.gif.more']

    ok.each do |image_url|
      assert new_product(image_url).valid?, "#{image_url} must be valid"
    end
    bad.each do |image_url|
      assert new_product(image_url).invalid?, "#{image_url} must be invalid"
    end
  end

  test 'product is not valid without a uniqie title' do
    product = Product.new(
      title: products(:ruby).title,
      description: 'yyy',
      price: 1,
      image_url: 'fred.gif',
    )
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end

  test 'product title length must more then 10 characters' do
    product = Product.new(
      title: 'Title',
      description: 'yyy',
      image_url: 'zzz.jpg',
      price: 1,
    )
    assert product.invalid?
    assert_equal ['is too short (minimum is 10 characters)'], product.errors[:title]

    product.title = 'Title test 100000'
    assert product.valid?
  end
end
