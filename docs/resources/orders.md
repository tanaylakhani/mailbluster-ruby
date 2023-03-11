# Resources - Fields

## Create

```ruby
mailbluster_client = Mailbluster::Client.new

create_order_attributes = {
  "id": "order_id_0001",
  "customer" => {
    "firstName": "Richard",
    "lastName": "Hendricks",
    "fields" => {
      "gender": "Male",
      "address": "Silicon Valley"
    },
    "email": "richard@example.com",
    "subscribed": true
  },
  "currency": "USD",
  "totalPrice": 10.43,
  "items" => [
    {
      "id": "101",
      "name": "Reign Html Template",
      "price": 2.13,
      "quantity": 1
    },
    {
      "id": "102",
      "name": "Slick Html Template",
      "price": 4.15,
      "quantity": 2
    }
  ]
}

created_order = mailbluster_client.orders.create(
  create_order_attributes
)
```

## Read

One order:
```ruby
mailbluster_client = Mailbluster::Client.new

found_order = mailbluster_client.orders.read("order_id_0001")
```

Many orders:
```ruby
mailbluster_client = Mailbluster::Client.new

found_orders = mailbluster_client.orders.read(page_no: 1)
found_order = found_orders.first
```

## Update

```ruby
mailbluster_client = Mailbluster::Client.new

updated_order = mailbluster_client.resource("orders").update(
  "order_id_0001",
  {
    "customer" => {
      "fields" => {
        "gender": "Male",
        "address": "Silicon Valley"
      },
      "subscribed": false,
      "meta" => {
        "gender": "Male"
      },
      "tags" => [
        "Developer"
      ]
    },
    "campaignId": 2,
    "currency": "USD",
    "totalPrice": 17.28,
    "items" => [
      {
        "id": "103",
        "name": "Falcon Html Template",
        "price": 4.49,
        "quantity": 2
      },
      {
        "id": "102",
        "name": "Slick Html Template",
        "price": 4.15,
        "quantity": 2
      }
    ]
  }
)
```

## Delete

```ruby
mailbluster_client = Mailbluster::Client.new

deleted_response = mailbluster_client.orders.delete("order_id_0001")
deleted_response # => "order_id_0001"
```
