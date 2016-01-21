# Jbcm

Jenkins job's build command manager

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jbcm'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jbcm

## Usage

### Initialize Jenkins Client

```ruby
require 'jbcm'

cli = Jbcm::Client.new(
  user_name: 'user',
  api_token: 'apitoken or password',
  hostname: 'jenkins.example.com')
```

Jbcm::Client initialize params is below

```
  user_name (required)
  api_token or password (required)
  hostname (required)
  scheme (default: 'https')
  port (default: '443')
```

### Fetch job's list

```ruby
cli.jobs
```

or

```ruby
cli.jobs(raw: true)
```

### Manage job's build command

fetch job's config

```ruby
job = cli.job(job_name)
```

see config

```ruby
job.config
```

see build command

```ruby
job.build_command
```

update build command

```ruby
job.build_command = NEW_COMMAND
job.update!
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/jbcm/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
