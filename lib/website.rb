class Website
  attr_reader :main_url, :nav_type, :main_links, :result, :items

  def initialize(options = {})
    @main_url   = options[:main_url]
    @nav_type   = options[:nav_type]
    @main_links = options[:main_links]
    @items      = options[:items]
    @result = {}
  end

  def add_to_result(category_title, items)
    result[category_title] = items
  end

  def drop_result
    @result = {}
  end

  def result_to_text
    text = ""
    result.each do |key, value|
      text << "#{key.upcase}\n"
      value.each do |item|
        text << "  {\n    "
        item.each do |k, v|
          text << "\"#{k}\" => \"#{v}\", "
        end
        text << "\n  }\n\n"
      end
      text << "\n"
    end
    text
  end
end
