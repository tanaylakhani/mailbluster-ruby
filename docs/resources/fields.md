# Resources - Fields

## Create

```ruby
mailbluster_client = Mailbluster::Client.new

create_field_attributes = {
"fieldLabel": "Gender",
"fieldMergeTag": "gender"
}

created_field = mailbluster_client.fields.create(
create_field_attributes
)
```

## Read

```ruby
mailbluster_client = Mailbluster::Client.new

found_fields = mailbluster_client.fields.read

found_field = found_fields.first
```

## Update

```ruby
mailbluster_client = Mailbluster::Client.new

updated_field = mailbluster_client.resource("fields").update(
    1653,
    {
        "fieldLabel" => "Gender",
        "fieldMergeTag" => "gender"
    }
)
```

## Delete

```ruby
mailbluster_client = Mailbluster::Client.new

deleted_response = mailbluster_client.fields.delete(1653)
deleted_response # => 1653
```
