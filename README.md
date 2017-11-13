# bundler-1.16-jruby-bug

- Works correctly on JRuby <9.1.14.0 with `bundler 1.15.4` (`jruby 9.1.14.0` has bundler 1.16.0 built-in.)
- Works correctly on MRI with all versions of bundler.
- Reported to JRuby, and confirmed as a bug there, fixed in latest `master`: https://github.com/jruby/jruby/issues/4849

## How to test

```shell
$ gem install bundler -v 1.16.0 # Older versions do not exhibit this behavior
$ gem build bundler-bug.gemspec
$ gem install bundler-bug-0.1.0.gem
$ bundle install
$ # Tweak gemspec, bump rack-cors dependency to 1.0.2
$ bundle install
$ bundle exec bundler_bug_app_server
$ curl http://localhost:9292/reload # in another shell
```

## Expected output

Puma should restart, using rack-cors 1.0.2 again

## Actual output

```shell
$ bundle exec bundler_bug_app_server
Running from /Users/plundberg/.rvm/gems/jruby-9.1.13.0/bin/bundler_bug_app_server
Puma starting in single mode...
* Version 3.10.0 (jruby 9.1.13.0 - ruby 2.3.3), codename: Russell's Teapot
* Min threads: 0, max threads: 16
* Environment: development
* Listening on tcp://0.0.0.0:9292
Use Ctrl-C to stop
* Restarting...
Running from /Users/plundberg/.rvm/gems/jruby-9.1.13.0/bin/bundler_bug_app_server
Gem::LoadError: You have already activated rack-cors 1.0.1, but your Gemfile requires rack-cors 1.0.2. Prepending `bundle exec` to your command may solve this.
  check_for_activated_spec! at /Users/plundberg/.rvm/gems/jruby-9.1.13.0/gems/bundler-1.16.0/lib/bundler/runtime.rb:313
             block in setup at /Users/plundberg/.rvm/gems/jruby-9.1.13.0/gems/bundler-1.16.0/lib/bundler/runtime.rb:31
                       each at org/jruby/RubyArray.java:1734
                       each at /Users/plundberg/.rvm/rubies/jruby-9.1.13.0/lib/ruby/stdlib/forwardable.rb:189
                        map at org/jruby/RubyEnumerable.java:830
                      setup at /Users/plundberg/.rvm/gems/jruby-9.1.13.0/gems/bundler-1.16.0/lib/bundler/runtime.rb:26
                      setup at /Users/plundberg/.rvm/gems/jruby-9.1.13.0/gems/bundler-1.16.0/lib/bundler.rb:107
                     <main> at /Users/plundberg/.rvm/gems/jruby-9.1.13.0/gems/bundler-1.16.0/lib/bundler/setup.rb:10
                    require at org/jruby/RubyKernel.java:955
                     (root) at /Users/plundberg/.rvm/rubies/jruby-9.1.13.0/lib/ruby/stdlib/rubygems/core_ext/kernel_require.rb:1
                     <main> at /Users/plundberg/.rvm/rubies/jruby-9.1.13.0/lib/ruby/stdlib/rubygems/core_ext/kernel_require.rb:55
                       load at org/jruby/RubyKernel.java:973
                     <main> at /Users/plundberg/.rvm/gems/jruby-9.1.13.0/gems/bundler-bug-0.1.0/exe/bundler_bug_app_server:7
```
