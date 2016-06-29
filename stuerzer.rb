require_relative 'lib/capybara_scraper'
require_relative 'lib/website'

stuerzer = Website.new(
  :main_url => 'http://stuerzer.de/index.php/home-en.html',
  :nav_type => :xpath,
  :main_links => "//ul[@class='level_2']/li/a",
  :items => "//div[@class='shortDescription']"
)

CapybaraScraper.scrap(stuerzer) do |divs, category_title|
  items = []

  divs.each do |div|
    item = {}
    keys = div.all('./strong').map(&:text)
    values = div.text.split(/#{keys.join('|')}/)[1..-1]
    values[-1].sub!(' Detailsightsubmit request', '')

    keys.each_with_index do |key, i|
      key = key.sub(':','').strip
      item[key] = values[i].strip
    end
    items << item
  end

  stuerzer.add_to_result(category_title, items)
end

File.open('result.txt', 'w') do |f|
  f << stuerzer.result_to_text
end

puts "Complete!"