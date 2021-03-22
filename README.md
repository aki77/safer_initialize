# SaferInitialize

Make ActiveRecord initialization less dangerous.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'safer_initialize'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install safer_initialize

## Usage

In `config/initializers/safer_initialize.rb`:

```ruby
SaferInitialize::Globals.attribute :tenant

SaferInitialize.configure do |config|
  config.error_handle = -> (e) { Rails.env.production? ? Bugsnag.notify(e) : raise(e) } # default: -> (e) { raise e }
end
```

In `app/models/project.rb`:

```ruby
belongs_to :tenant

scope :active, -> { where(deleted_at: nil) }

safer_initialize message: 'Forbidden tenant!' do |project|
  !SaferInitialize::Globals.tenant || SaferInitialize::Globals.tenant == project.tenant
end
safer_initialize :active?, message: 'Not active project!'

def active?
  deleted_at.nil?
end
```

In `app/controllers/application_controller.rb`:

```ruby
before_action :set_tenant

private

def set_tenant
  SaferInitialize::Globals.tenant = current_tenant
end
```

In `app/views/projects/index.html.haml`:

```haml
# raise error
- current_tenant.projects.each do |project|
  = project.name

- Project.active.each do |project|
  = project.name

# good
- current_tenant.projects.active.each do |project|
  = project.name

- SaferInitialize.with_safe do
  - current_tenant.projects.each do |project|
    = project.name
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SaferInitialize project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/aki77/safer_initialize/blob/master/CODE_OF_CONDUCT.md).
