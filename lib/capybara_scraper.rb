require 'capybara/poltergeist'

module CapybaraScraper

  def self.session
    unless @session
      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(app, js_errors: false)
      end
      Capybara.default_driver = :poltergeist
      @session = Capybara.current_session
    end

    @session
  end

  def self.scrap(website)
    Capybara.default_selector = website.nav_type

    session.visit(website.main_url)
    links = session.all(website.main_links).map {|i| [i['href'], i.text] }

    links.each do |href, name|
      session.visit href
      next if (items = session.all(website.items)).empty?
      yield items, name
    end

    website.result
  end

end
