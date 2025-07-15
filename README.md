[![Build Status](https://travis-ci.org/nateleavitt/infusionsoft.svg?branch=master)](https://travis-ci.org/nateleavitt/infusionsoft)
[![Coverage Status](https://coveralls.io/repos/nateleavitt/infusionsoft/badge.svg?branch=master&service=github)](https://coveralls.io/github/nateleavitt/infusionsoft?branch=master)


# The Keap Ruby Gem
A Ruby wrapper for the Keap API

**update notes**
* v1.4.1 - Proper error handling REST api
* v1.3.6 - Ruby v3 compatibility
* v1.3.5 - Rest API is now supported
* v1.2.2 - Catching Keap API SSL handshake issues
* v1.2.1 - Added OAuth support
* v1.2.0 - Added `invoice_add_subscription` call to mirror Keap API parameters to eventually replace `invoice_add_recurring_order`
* maybe?? - Going to add Keap API authentication Oauth flow. Also, I'm thinking of rewriting parts of it to make the calls more user friendly and adding some convenience methods. If you have any suggestions, let me know.
* 07/21/2015 - Implementation of tests and build/coverage (Thanks! @TheMetalCode)
* v1.1.8 - Added a default user-agent in the headers. Also, give the
  ability to set your own user-agent in the config block.
* v1.1.5 - Added a custom logger option.  This will allow you to track all api calls/results in a separate log file.  Defaults to $stdout if none is specified. To add logger specify `api_logger` in your [config block](#setup--configuration).

## <a name="installation">Installation</a>
    ruby 3.* gem install infusionsoft
    ruby 2.* gem install infusionsoft -v 1.3.5

## <a name="documentation">Documentation</a>
[http://rubydoc.info/gems/infusionsoft](http://rubydoc.info/gems/infusionsoft)

## <a name="setup">Setup & Configuration</a>
1. **Rails 2.3** - add `config.gem 'infusionsoft'` **Rails >= 3** - add `'infusionsoft'` to your `Gemfile`
2. Enable the API on your Keap account (if you haven't already) and generate your API Key: [See Keap Doc](https://classic-infusionsoft.knowledgeowl.com/help/api-key)

```ruby
### XML-RPC API (Legacy)

The XML-RPC API is the original Infusionsoft API. Use this for legacy integrations or when you need access to older Infusionsoft features.

#### Setup for XML-RPC

```ruby
# Added to your config\initializers file
Infusionsoft.configure do |config|
  config.api_url = 'YOUR_INFUSIONSOFT_URL' # example infused.infusionsoft.com DO NOT INCLUDE https://
  config.api_key = 'YOUR_INFUSIONSOFT_SERVICE_KEY' # Or Oauth Access Token or Legacy Key.
  config.api_logger = Logger.new("#{Rails.root}/log/infusionsoft_api.log") # optional logger file
  config.use_oauth = true # false if using legacy api key
end
```

#### XML-RPC Usage Examples

```ruby
# Get a users first and last name using the DataService
Infusionsoft.data_load('Contact', contact_id, [:FirstName, :LastName])

# Get a list of custom fields
Infusionsoft.data_find_by_field('DataFormField', 100, 0, 'FormId', -1, ['Name'])
# Note, when updating custom fields they are case sensisitve and need to be prefaced with a '_'

# Update a contact with specific field values
Infusionsoft.contact_update(contact_id, { :FirstName => 'first_name', :Email => 'test@test.com' })

# Add a new Contact
Infusionsoft.contact_add({:FirstName => 'first_name', :LastName => 'last_name', :Email => 'test@test.com'})

# Create a blank Invoice
invoice_id = Infusionsoft.invoice_create_blank_order(contact_id, description, Date.today, lead_affiliate_id, sale_affiliate_id)

# Then add item to invoice
Infusionsoft.invoice_add_order_item(invoice_id, product_id, product_type, amount, quantity, description_here, notes)

# Then charge the invoice
Infusionsoft.invoice_charge_invoice(invoice_id, notes, credit_card_id, merchange_id, bypass_commissions)
```

### REST API (Recommended)

The REST API is the modern, recommended way to interact with Keap. It provides better error handling, cleaner responses, and access to the latest features.

#### Setup for REST API

For REST API calls, you'll need to obtain an OAuth access token. Here's how to get started:

##### 1. Create an OAuth Application

First, create an OAuth application in your Keap account to get your `client_id` and `client_secret`.

##### 2. Generate Authorization URL

```ruby
# Generate the authorization URL for user consent
auth_url = Infusionsoft::Rest::Token.auth_url(
  client_id: 'YOUR_CLIENT_ID',
  redirect_uri: 'YOUR_REDIRECT_URI'
)

# Redirect user to this URL to authorize your application
puts auth_url
# => "https://signin.infusionsoft.com/app/oauth/authorize?client_id=YOUR_CLIENT_ID&redirect_uri=YOUR_REDIRECT_URI&scope=full&response_type=code"
```

##### 3. Exchange Authorization Code for Token

After the user authorizes, you'll receive an authorization code. Exchange it for an access token:

```ruby
# Exchange the authorization code for an access token
token = Infusionsoft::Rest::Token.get_token(
  client_id: 'YOUR_CLIENT_ID',
  client_secret: 'YOUR_CLIENT_SECRET',
  redirect_uri: 'YOUR_REDIRECT_URI',
  code: 'AUTHORIZATION_CODE_FROM_STEP_2'
)

# The token object contains access_token, refresh_token, and expiration
puts token.access_token
puts token.refresh_token
puts token.expiration
```

##### 4. Refresh Token (when needed)

Access tokens expire, so you'll need to refresh them:

```ruby
# Refresh the access token using the refresh token
new_token = Infusionsoft::Rest::Token.refresh(
  client_id: 'YOUR_CLIENT_ID',
  client_secret: 'YOUR_CLIENT_SECRET',
  refresh_token: token.refresh_token
)

# Check if token is still valid
if token.valid?
  puts "Token is still valid"
else
  puts "Token has expired, need to refresh"
end
```

#### REST API Usage Examples

```ruby
# Example: GET request (v1)
response = Infusionsoft.get('/contacts', token, query: { email: 'test@example.com' }, version: 'v1')
puts response

# Example: POST request (v2)
response = Infusionsoft.post('/paymentMethodConfigs', token, payload: { contact_id: 1234 }, version: 'v2')
puts response

# Example: Handling errors
begin
  Infusionsoft.post('/paymentMethodConfigs', token, payload: { contact_id: 1234 }, version: 'v2')
rescue Infusionsoft::InvalidParameterError => e
  puts "Invalid parameter: #{e.message}"
rescue Infusionsoft::NoAccessError => e
  puts "No access: #{e.message}"
rescue Infusionsoft::UnexpectedError => e
  puts "Unexpected error: #{e.message}"
end
```

**Notes:**
- The `version` parameter can be `'v1'` or `'v2'` depending on the API endpoint
- Errors are raised as Ruby exceptions with helpful messages
- The REST API provides better error handling and cleaner responses than XML-RPC

## <a name="contributing">Contributing</a>
In the spirit of [free software](http://www.fsf.org/licensing/essays/free-sw.html), **everyone** is encouraged to help improve this project.

Here are some ways *you* can contribute:

* by using alpha, beta, and prerelease versions
* by reporting bugs
* by suggesting new features
* by writing or editing documentation
* by writing specifications
* by writing code (**no patch is too small**: fix typos, add comments, clean up inconsistent whitespace)
* by refactoring code
* by closing [issues](https://github.com/nateleavitt/infusionsoft/issues)
* by reviewing patches

## <a name="issues">Submitting an Issue</a>
We use the [GitHub issue tracker](https://github.com/nateleavitt/infusionsoft/issues) to track bugs and
features.

## <a name="rubies">Supported Rubies</a>
This library aims to support the following Ruby implementations:

* Ruby >= 2.3.8
* [JRuby](http://www.jruby.org/)
* [Rubinius](http://rubini.us/)
* [Ruby Enterprise Edition](http://www.rubyenterpriseedition.com/)

If something doesn't work on one of these interpreters, it should be considered
a bug.

This library may inadvertently work (or seem to work) on other Ruby
implementations, however support will only be provided for the versions listed
above.

If you would like this library to support another Ruby version, you may
volunteer to be a maintainer. Being a maintainer entails making sure all tests
run and pass on that implementation. When something breaks on your
implementation, you will be personally responsible for providing patches in a
timely fashion. If critical issues for a particular implementation exist at the
time of a major release, support for that Ruby version may be dropped.

## <a name="todos">Todos</a>
* Need to fully implement testing
* Need to add a history log for additional contributers

## <a name="copyright">Copyright</a>
Copyright (c) 2019 Nathan Leavitt

See [MIT LICENSE](https://github.com/nateleavitt/infusionsoft/blob/master/LICENSE.md) for details.

