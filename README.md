# MobilePay

Actions with payments in MobilePay system.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mobilepay'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mobilepay

## Usage

Create MobilePay object.

```ruby
  require 'mobilepay'
  client = Mobilepay::Client.new('merchant_id', 'subscription_key')
```

### Payment Status

Request for getting the status of a given order is #payment_status.

```ruby
  client.payment_status order_id: '111', body: '{}'
```

    order_id - Order ID, required
    body - text body for request, optional

#### Responces

```ruby
  {
    "LatestPaymentStatus": "Captured",
    "TransactionId": "61872634691623746",
    "OriginalAmount": 123.45
  }
```

### Payment Transactions

Request for getting the transactions for a given order is #payment_transactions.

```ruby
  client.payment_transactions order_id: '111', body: '{}'
```

    order_id - Order ID, required
    body - text body for request, optional

#### Responces

```ruby
  [
    {
      "TimeStamp": "2016-04-08T07:45:36.533Z",
      "PaymentStatus": "Captured",
      "TransactionId": "61872634691623746",
      "Amount": 11.5
    },
    {
      "TimeStamp": "2016-04-09T07:45:36.672Z",
      "PaymentStatus": "Cancelled",
      "TransactionId": "61872634691623799",
      "Amount": 18.9
    }
  ]
```

### Reservations

Request for getting the reservations for a particular date/time interval, and alternatively also for a specific customer is #reservations.

```ruby
  client.reservations datetime_from: 'YYYY-MM-DDTHH_MM', datetime_to: 'YYYY-MM-DDTHH_MM', customer_id: '111', body: '{}'
```

    datetime_from - Date from, required
    datetime_to - Date to, required
    customer_id - Customer ID, optional
    body - text body for request, optional

#### Responces

```ruby
  [
    {
      "TimeStamp": "2016-04-08T07_45_36Z",
      "OrderId": "DB TESTING 2015060908",
      "TransactionId": "61872634691623746",
      "Amount": 100.25,
      "CaptureType": "Full"
    },
    {
      "TimeStamp": "2016-04-09T07_45_36Z",
      "OrderId": "DB TESTING 2015060908",
      "TransactionId": "61872634691623799"
      "Amount": 100.25,
      "CaptureType": "Partial"
    }
  ]
```

### Refund Amount

Request for refunding the transaction amount, either the entire amount or just a part of the amount is #refund_amount.

```ruby
  client.refund_amount order_id: '111', body: '{}'
```

    order_id - Order ID, required
    body - text body for request, optional

#### Request body examples

```ruby
  {
    "Amount" : 100.00,
    "BulkRef" : "123456789"
  }

  {
    "Amount" : 100.00
  }

  {
  }
```

#### Responces

```ruby
  {
    "TransactionId" : "61872634691623757",
    "OriginalTransactionId" : "61872634691623746",
    "Remainder" : 20.00
  }
```

### Capture Amount

Request for capturing the transaction, i.e. carries out the actual payment is #capture_amount.

```ruby
  client.capture_amount order_id: '111', body: '{}'
```

    order_id - Order ID, required
    body - text body for request, optional

#### Request body examples

```ruby
  {
    "Amount" : 100.00,
    "BulkRef" : "123456789"
  }

  {
    "Amount" : 100.00
  }

  {
  }
```

#### Responces

```ruby
  {
    "TransactionId" : "61872634691623746"
  }
```

### Cancel Reservation

Request for canceling previously made reservations is #cancel_reservation.

```ruby
  client.cancel_reservation order_id: '111', body: '{}'
```

    order_id - Order ID, required
    body - text body for request, optional

#### Responces

```ruby
  {
    "TransactionId" : "61872634691623746"
  }
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kortirso/mobilepay.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
