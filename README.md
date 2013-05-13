# Kiss Amazon-MWS

Update prices and quantity on Amazon via Amazon Marketplace Web Service, without ever thinking about hexdigest and signature.

## Installation

Add this line to your application's Gemfile:

    gem 'kiss_amazon_mws'

## Usage

1. Put your secrets in config

If you don't have any secretes you might wanna sign up [here](https://developer.amazonservices.com/)

```ruby
mws_config = {
  aws_access_key_id: "AKIAI4********",
  secret_access_key: "ZNC+tV/****aZATR7cDW5+*********9FLdLMDQM",
  seller_id:         "A1XT*******MDM",
  marketplace_id:    "ATVP*******ER",
  amazon_url:        "mws.amazonservices.com"
}
```

2. Format collection with this attributes: [sku, price, quantity]

```ruby
data = [
          ['700000005', 10.15, 1],
          ['700000006', 15.65, 6],
          ['700000007', 14.12, 3]
       ]
```

If you want to change just prices, leave out the quantity:

```ruby
data = [
          ['700000005', 10.15],
          ['700000006', 15.65],
          ['700000007', 14.12]
       ]
```

3. Send to Amazon MWS

```ruby
response = KissMWS.send_feed(data, mws_config)
```
