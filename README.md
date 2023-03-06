# mailbluster

[![Gem Version](https://badge.fury.io/rb/mailbluster.svg)](https://rubygems.org/gems/mailbluster)
[![CI](https://github.com/tanaylakhani/mailbluster-ruby/actions/workflows/ci.yml/badge.svg)](https://github.com/tanaylakhani/mailbluster-ruby/actions/workflows/ci.yml)

Ruby client for the [Mailbluster API](https://app.mailbluster.com/api-doc).

---

- [Quick start](#quick-start)
- [Usage](#usage)
- [Demo script](#demo-script)
- [API Documentation](#api-documentation)
- [Detailed mailbluster-ruby documentation](#detailed-mailbluster-ruby-documentation)
- [Support](#support)
- [License](#license)
- [Code of conduct](#code-of-conduct)
- [Contribution guide](#contribution-guide)

## Quick start

```bash
gem install mailbluster
```

or with bundler:

```bash
bundler add mailbluster
```

then configure the gem:

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

## Usage

```ruby
mailbluster_client = Mailbluster::Client.new
lead = mailbluster.leads.create(email: 'lead@example.org')
puts lead.inspect # => #<Mailbluster::Resource @resource_type=#<Mailbluster::ResourceType::Lead>, @raw_attributes={"id"=>262093545 ...}>

mailbluster.leads.find(lead.email) # => #<Mailbluster::Resource @resource_type=#<Mailbluster::ResourceType::Lead>, @raw_attributes={"id"=>262093545 ...}>
```

### Demo script
In the `bin` directory, there is a `demo` script that you can run to see how to use the gem and to create example leads in Mailbluster. You can run it like this:

```bash
env MAILBLUSTER_API_KEY=your-api-key ruby bin/demo
```

## Mailbluster API Documentation
Official documentation for the Mailbluster API can be found at <https://app.mailbluster.com/api-doc>.

## Detailed mailbluster-ruby documentation

- [Detailed: API Documentation](docs/api_documentation.md)
- [Detailed: Client](docs/client.md)
- [Detailed: Configuration](docs/configuration.md)
- [Detailed: Resources](docs/resources.md)


## Support

If you want to report a bug, or have ideas, feedback or questions about the gem, [let me know via GitHub issues](https://github.com/tanaylakhani/mailbluster-ruby/issues/new) and I will do my best to provide a helpful answer. Happy hacking!

## License

The gem is available as open source under the terms of the [MIT License](LICENSE.txt).

## Code of conduct

Everyone interacting in this project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).

## Contribution guide

Pull requests are welcome!
