# SelectBy

SelectBy is a ruby gem that adds some equality methods onto the Array class.

If you have ever used select in this manner:

```
["smith","pete","tom","sara"].select { |name| name.first == "s" && name.size == 5 }.map(&:upcase) # => ["SMITH"]
```
this can be accomplished with

```
["smith","pete","tom","sara"].select_by(:first => "s", :size => 5, &:upcase)
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'select_by'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install select_by

## Usage

By including this gem you will add :select_by (aliased as find_all_by), :reject_by, :detect_by (aliased as find_by), :partition_by methods to the Array class. if a hash is provided as the argument use each hash key as a method name and value as what the method should return if any of key/value pairs are not callable or do not match the reciever based on equality then reject the element of the array.  if the argument that is provided is a callable method (calling to_s on the object returns a method the element responds to) then call that method on each element only returning the elements that return a truthy value (similar to select(&:method)).

if you provide a code block the method will apply that code block to each returned element and return the resulting array

```
["Smith", "peter"].detect_by(:size => 5) # => "Smith"
["Smith", "peter"].detect_by(:size => 5, &:downcase) # => "smith"
["Smith", "peter"].select_by(:size => 5) {|name| name.downcase} # => ["smith", "peter"]
["Smith", "peter"].reject_by(:size => 5, &:downcase) # => []
["Smith", "peter"].partition_by(:size => 5) # => [["Smith"],["peter"]]

when the object does not respond to the key the selecting block assumes it is falsey
["Smith", "peter"].reject_by(:peter => 5, &:downcase) # => ["smith", "peter"]
["Smith", "peter"].select_by(:peter => 5, &:downcase) # => []
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/select_by. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

