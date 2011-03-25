Easy Automation
===============

Friendly Automation Testing Framework, tired of update every single test when developers change an XPath, id, class, etc? This is for you.

Design
------

This framework uses common patterns to make maintainability easy and scalable tests. It's divided in:

* Pages
* Page Elements
* Test
* Data for Tests
* Runner

Challenges when developing automated tests
------

* FrontEnd is always changing, and it's hard to get tests up to date, any small change, id renamed, nested table, etc, breaks all the tests
* Separate components in order to allow easy patching for new changes.
* Some tests depend in other
* If you need to update data used by test, you touch test code

Design
------

We will implement kind of MVC pattern for automation testing, separating xpath's information, data for tests and the runner.

    +---------+       +----------------------+
    | Pages   |<------| EasyAutomation::Page |
    +---------+       +----------------------+
         | \  +----------+
         |   \| Elements |
         v    +----------+
    +---------+       +----------+       +-------------+
    | Suite   |<----->| Runner   |<----->| Selenium RC |
    +---------+       +----------+       +-------------+
         ^    +--------+
         |   /|  Data  |
         |  / +--------+
    +---------+       +----------------------+
    | Tests   |<------| EasyAutomation::Test |
    +---------+       +----------------------+

Instead of work with actions => elements, we can use element => actions
Normally:
    Selenium.click('id:btn')
    Selenium.enter('id:input_text', 'Text')

With this framework:
    page.btn.click
    page.input_text.enter('Text')

You have a lot of [actions](http://selenium.rubyforge.org/rdoc/classes/Selenium/WebPage.html) to use with your page elements, click, text, enter, etc.

More Reference: http://selenium.rubyforge.org/rdoc/classes/Selenium/

Runner - Configuring your tests
------
You can change any behaviour using EasyAutomation::Runner.config helper, options:
    EasyAutomation::Runner.configure do |config|
      # Selenium Configurations
      config.url = "http://www.google.com"
      config.browser = "*safari" # "*firefox", "*chrome"
      config.selenium_port = 4444
      config.selenium_timeout = 1000
      #if specified, it won't start selenium RC and will attempt to connect to remote selenium server
      config.selenium_host = "localhost"

      # Hooks
      config.before :all do
        puts 'Starting Tests'
      end
      config.after :all do
        puts 'Tests finished, halting'
      end

      config.before :each_test do
        # Do something
      end
      config.after :each_test do
        # Do something
      end

      config.before :each_suite do
        # Do something
      end
      config.after :each_suite do
        # Do something
      end
    end

Example
-------
Structure:

    /runner_demo.rb
    test/
      main_page_test.rb
      data/
        mainpagetest.yml
    pages/
      main_page.rb
      elements/
        mainpage.yml

main_page.rb
    class MainPage < EasyAutomation::Page
      def login_field
        @browser.text_field(:id, @elements.login)
      end
      def password_field
        @browser.text_field(:id, @elements.password)
      end
    end

mainpage.yml
    login: xpath=id('login')
    password: xpath=id('password')

main_page_test.rb
    class MainPageTest < EasyAutomation::Test
      def initialize test_name, path = 'data'
        super(test_name, path)
      end

      def login_failed_test
        main_page = MainPage.new(@browser, 'elements')
        main_page.login_field.type @data.email
        main_page.password_field.type @data.password
        assert_true main_page.include?"wrong email/password combination with: #{@data.email}"
      end
    end

mainpagetest.yml
    login_failed_test:
      email: wrong@email.com
      password: pasguord

runner_demo.rb
    require 'rubygems'
    require 'easy-automation'
    Dir["#{File.dirname(__FILE__)}/*/*.rb"].each { |f| require f }

    EasyAutomation::Runner.configure do |config|
      config.url = "http://www.google.com"
      config.browser = "*safari"
      config.before :all do
        puts 'Starting Tests'
      end
      config.after :all do
        puts 'Tests finished, halting'
      end
    end
    demo_suite = EasyAutomation::Suite.new('Demo')
    demo_suite.add(MainPageTest)
    EasyAutomation::Runner.run demo_suite

Find some working code under examples folder, to see it search exmple on action, execute:
    cd examples/search
    bundle exec ruby example.rb

Roadmap
-------
* More hooks [before|after] [:all|:each] [:test|:suite]
* Update Selenium gem to use latest selenium-RC and fix weird firefox crashes.
* Multi browser
* Wait for element to be loaded event
* Rake integration
* Retry on failed tests
* Parallel tests
* Nice test results
* Remote Selenium RC/Grid
* History graphs
* Performance analysis graphs

Order may matter


Version Changes
--------

From 0.0.1 to 0.0.2
--------
* Multiple browsers support
* [before|after] [:all|:each] [:test|:suite] hooks
* Remote Selenium RC

From 0.0.2 to 0.1.0
-------
* Retry failed tests
* Selenium Grid integration

Contributing
------------

1. Fork it.
2. Create a branch (`git checkout -b my_branch`)
3. Commit your changes (`git commit -am "Fixing your bugs"`)
4. Push to the branch (`git push origin my_branch`)
5. Create an [Issue][1] with a link to your branch
6. Enjoy a refreshing Beer and wait
