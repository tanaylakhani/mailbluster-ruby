# Resources - Fields

## Create

```ruby
mailbluster_client = Mailbluster::Client.new

create_product_attributes = {
  "id": "101",
  "name": "Reign Html Template"
}

created_product = mailbluster_client.products.create(
  create_product_attributes
)
```

## Read

One product:
```ruby
mailbluster_client = Mailbluster::Client.new

found_product = mailbluster_client.products.read(101)
```

Many products:
```ruby
mailbluster_client = Mailbluster::Client.new

found_products = mailbluster_client.products.read(page_no: 1)
found_product = found_products.first
```

## Update

```ruby
mailbluster_client = Mailbluster::Client.new

updated_product = mailbluster_client.resource("products").update(
  101,
  {
    "name": "Reign PRO Html Template"
  }
)
```

## Delete

```ruby
mailbluster_client = Mailbluster::Client.new

deleted_response = mailbluster_client.products.delete(101)

deleted_response # => 101
```
