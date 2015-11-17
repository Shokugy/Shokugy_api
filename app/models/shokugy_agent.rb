class ShokugyAgent < Mechanize
  BASE_PATH = 'http://www.gnavi.co.jp'
  DINNER_PATH = 'http://r.gnavi.co.jp/area/jp/rs/'
  LUNCH_PATH = 'http://r.gnavi.co.jp/area/jp/lunch/'
  DINNER_URLS = []
  LUNCH_URLS = []

  def initialize
    super
    get_url(DINNER_PATH, DINNER_URLS)
    get_url(LUNCH_PATH, LUNCH_URLS)
  end

  def restaurant_info
    get_show(DINNER_URLS)
    get_show(LUNCH_URLS)
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
    # next_url = first_page.at('.next span a')[:href]
    # while next_url
    #   next_page = self.get(next_url)
    #   next_page.search('.rstrntH1 a').each do |url|
    #     urls << url[:href]
    #     puts url[:href]
    #   end
    #   next_url = next_page.at('.next span a')[:href]
    #   break if next_url.nil?
    # end
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
    image_url = page.at('.figure img')[:src] if page.at('.figure img')[:src]
    postal_code = page.at('#info-table .adr').inner_text if page.at('#info-table .adr')
    addres = page.at('#info-table .region').inner_text if page.at('#info-table .region')

    restaurant = Restaurant.where(link: link).first_or_initialize
    restaurant.name = name
    restaurant.name_kana = name_kana
    restaurant.image_url = image_url
    restaurant.postal_code = postal_code
    restaurant.addres = addres
    restaurant.save
  end

end
