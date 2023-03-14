# Mailbluster::Client
Mailbluster client is a wrapper over Mailbluster API. It allows to perform HTTP operations on Mailbluster resources. Usually you want to use ResourceType simplifiers instead of this classes' `get`, `put`, `post` and `delete` methods.

## Usage

```ruby
mailbluster_client = Mailbluster::Client.new
lead = mailbluster_client.leads.create(email: 'lead@example.org')
puts lead.inspect # => #<Mailbluster::Lead id: 1, email: "lead@example.org", ...>

mailbluster_client.leads.read(lead.id) # => #<Mailbluster::Lead id: 1, ...>
```

## Errors
There are few errors that can be raised by the client:

* `Mailbluster::Error::Forbidden` - when the request is forbidden - usually when the API key is invalid
* `Mailbluster::Error::NotFound` - when the resource is not found
* `Mailbluster::Error::UnprocessableEntity` - when the request is unprocessable - usually when the attributes are invalid

# User Agent

The client sets the `User-Agent` header to `mailbluster-ruby/#{Mailbluster::VERSION}/rest-client/2.1.0 (darwin21.4.0 x86_64) ruby/2.3.8p459`.


