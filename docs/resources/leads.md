# Resources - Leads

## Create

```ruby
mailbluster_client = Mailbluster::Client.new

create_lead_attributes = {
  "firstName": "Richard",
  "lastName": "Hendricks",
  "fields" => {
    "gender": "Male",
    "address": "Silicon Valley"
  },
  "email": "richard@example.com",
  "ipAddress": "162.213.1.246",
  "subscribed": false,
  "doubleOptIn": true,
  "meta": {
    "company": "Pied Piper",
    "role": "CEO"
  },
  "tags": [
    "iPhone User",
    "Startup"
  ],
  "overrideExisting": true
}

created_lead = mailbluster_client.leads.create(
  create_lead_attributes
)
```

## Read

```ruby
mailbluster_client = Mailbluster::Client.new

found_lead = mailbluster_client.leads.read("richard@example.com")
```

## Update

```ruby
mailbluster_client = Mailbluster::Client.new

updated_lead = mailbluster_client.resource("leads").update(
  "richard@example.com",
  {
    "fields" => {
      "gender": "Male",
      "address": nil,
      "hobby": "Programming"
    },
    "subscribed": true,
    "meta" => {
      "company": "Piper Net"
    },
    "addTags" => [
      "Entrepreneur"
    ],
    "removeTags" => [
      "iPhone User"
    ]
  }
)
```

## Delete

```ruby
mailbluster_client = Mailbluster::Client.new

deleted_response = mailbluster_client.leads.delete("richard@example.com")

deleted_response # => "5a91f0b2d2c1e5c3229d906d978b7337"
```
