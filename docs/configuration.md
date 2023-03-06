# Mailbluster::Configuration

Mailbluster offers a number of configuration options to customize the behavior of the client. 

then configure the gem:

## API KEY

You can configure API KEY using built-in configuration:

```ruby
Mailbluster.configure do |config|
  config.api_key = 'your-api-key'
end
```

or with environment variables:

```bash
env MAILBLUSTER_API_KEY=your-api-key ruby app.rb
```

or directly on the Client instance:

```ruby
mailbluster_client = Mailbluster::Client.new('your-api-key')
```
