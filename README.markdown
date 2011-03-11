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

    +---------+       +----------+
    | Pages   |<------| Elements |
    +---------+       +----------+
         |
         v
    +---------+       +----------+       +-------------+
    | Suite   |<----->| Runner   |<----->| Selenium RC |
    +---------+       +----------+       +-------------+
         ^
         |
    +---------+       +----------+
    | Tests   |<------| Data     |
    +---------+       +----------+


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

    demo_suite = EasyAutomation::Suite.new('Demo')
    demo_suite.add(MainPageTest)
    EasyAutomation::Runner.run demo_suite

Roadmap
-------
* Fix that ugly path param on Page and Test initializers
* Retry on failed tests
* Parallel tests
* Nice test results
* History graphs
* Performance analysis graphs
* Better data/elements including
* Remote Selenium RC/Grid

Contributing
------------

1. Fork it.
2. Create a branch (`git checkout -b my_branch`)
3. Commit your changes (`git commit -am "Fixing your bugs"`)
4. Push to the branch (`git push origin my_branch`)
5. Create an [Issue][1] with a link to your branch
6. Enjoy a refreshing Beer and wait
