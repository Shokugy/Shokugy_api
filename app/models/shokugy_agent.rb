class ShokugyAgent < Mechanize
  BASE_PATH = 'http://www.gnavi.co.jp'
  # 東京ディナー
  TOKYO_DINNER_PATH = 'http://r.gnavi.co.jp/area/tokyo/rs/'
  TOKYO_DINNER_URLS = []
  # 東京ランチ
  TOKYO_LUNCH_PATH = 'http://r.gnavi.co.jp/area/tokyo/lunch/'
  TOKYO_LUNCH_URLS = []

  def initialize
    super
    get_url(TOKYO_DINNER_PATH, TOKYO_DINNER_URLS)
    get_url(TOKYO_LUNCH_PATH, TOKYO_LUNCH_URLS)
  end

  def restaurant_info
    get_show(TOKYO_DINNER_URLS)
    get_show(TOKYO_LUNCH_URLS)
  end

  private
  def path(to: '')
    "#{BASE_PATH}/#{to}"
  end

  def get_url(path, urls)
    first_page = self.get(path, urls)
    first_page.search('.rstrntH1 a').each do |url|
      urls << url[:href]
      puts url[:href]
    end
    next_url = first_page.at('.next span a')[:href]
    while next_url
      next_page = self.get(next_url)
      next_page.search('.rstrntH1 a').each do |url|
        urls << url[:href]
        puts url[:href]
      end
      if next_page.at('.next span a')
        next_url = next_page.at('.next span a')[:href]
      else
        break
      end
    end
  end

  def get_show(urls)
    urls.each do |url|
      page = self.get(url)
      if page.at('#info-table')
        restaurant_save(url, page)
      else
        page = self.get(url + "map")
        restaurant_save(url, page)
      end
    end
  end

  def restaurant_save(url, page)
    name = page.at('#info-table #info-name').inner_text if page.at('#info-table #info-name')
    name_kana = page.at('#info-table #info-kana').inner_text if page.at('#info-table #info-kana')
    link = url
    image_url = "http:" + page.at('.figure img')[:src] if page.at('.figure img')
    postal_code = molded_code(page.at('#info-table .adr').inner_text) if page.at('#info-table .adr')
    address = page.at('#info-table .region').inner_text if page.at('#info-table .region')

    restaurant = Restaurant.where(link: link).first_or_initialize
    restaurant.name = name
    restaurant.name_kana = name_kana
    restaurant.image_url = image_url
    restaurant.postal_code = postal_code
    restaurant.address = address
    restaurant.save
  end

  def molded_code(code)
    code.gsub(/[^\x01-\x7E]/, "").gsub(" ", "").gsub("\n", "").slice(0, 8)
  end

end
