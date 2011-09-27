# The Infusionsoft Ruby Gem
A Ruby wrapper for the Infusionsoft API

**This is a complete rewrite and has been implemented as a RubyGem**
All previous versions will need to update their calls to follow the new schema

## <a name="installation">Installation</a>
    gem install infusionsoft

## <a name="documentation">Documentation</a>
[http://rubydoc.info/gems/infusionsoft/frames](http://rubydoc.info/gems/infusionsoft/frames)

## <a name="setup">Setup & Configuration</a>
1. **Rails 2.3** - add `config.gem 'infusionsoft'` **Rails 3** - add `'infusionsoft'` to your `Gemfile`
2. Then create an initializer in `config\initializers` called infusionsoft.rb and the following


    Infusionsoft.configure do |config|
      config.api_url = 'YOUR_INFUSIONSOFT_URL' # example infused.infusionsoft.com
      config.api_key = 'YOUR_INFUSIONSOFT_API_KEY'
    end

## <a name="examples">Usage Examples</a>

    # Get a users first and last name using the DataService
    Infusionsoft.data_load('Contact', contact_id, [:FirstName, :LastName])

    # Update a contact with specific field values
    Infusionsoft.contact_upudate(contact_id, { :FirstName => 'first_name', :Email => 'test@test.com' })

    # Add a new Contact
    Infusionsoft.contact_add({:FirstName => 'first_name', :LastName => 'last_name', :Email => 'test@test.com'})

    # Create a blank Invoice
    invoice_id = Infusionsoft.invoice_create_blank_order(contact_id, description, Date.today, lead_affiliate_id, sale_affiliate_id)

    # Then add item to invoice
    Infusionsoft.invoice_add_order_item(invoice_id, product_id, product_type, amount, quantity, description_here, notes)

    # Then charge the invoice
    Infusionsoft.invoice_charge_invoice(invoice_id, notes, credit_card_id, merchange_id, bypass_commissions)


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
features. Before submitting a bug report or feature request, check to make sure it hasn't already
been submitted. You can indicate support for an existing issuse by voting it up. When submitting a
bug report, please include a [Gist](https://gist.github.com/) that includes a stack trace and any
details that may be necessary to reproduce the bug, including your gem version, Ruby version, and
operating system. Ideally, a bug report should include a pull request with failing specs.

## <a name="pulls">Submitting a Pull Request</a>
1. Fork the project.
2. Create a topic branch.
3. Implement your feature or bug fix.
4. Add documentation for your feature or bug fix.
5. Run <tt>bundle exec rake doc:yard</tt>. If your changes are not 100% documented, go back to step 4.
6. Add specs for your feature or bug fix.
7. Run <tt>bundle exec rake spec</tt>. If your changes are not 100% covered, go back to step 6.
8. Commit and push your changes.
9. Submit a pull request. Please do not include changes to the gemspec, version, or history file. (If you want to create your own version for some reason, please do so in a separate commit.)

## <a name="rubies">Supported Rubies</a>
This library aims to support the following Ruby implementations:

* Ruby 1.8.7
* Ruby 1.9.1
* Ruby 1.9.2
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
Copyright (c) 2011 Nathan Leavitt & Infused Systems
See [LICENSE](https://github.com/nateleavitt/infusionsoft/blob/master/LICENSE.md) for details.

