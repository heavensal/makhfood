# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# require 'selenium-webdriver'
# # Spécifiez le chemin vers le ChromeDriver si ce n'est pas dans votre PATH
# Selenium::WebDriver::Chrome::Service.driver_path = "/home/adam/chromedriver-linux64/chromedriver"

# # Créez une instance du navigateur Chrome
# options = Selenium::WebDriver::Chrome::Options.new
# options.add_argument('--headless')
# options.add_argument('--disable-gpu')
# options.add_argument('--no-sandbox')

# def create_product(driver, wait, marque)
#   product = Product.new

#   begin
#     product.name = wait.until { driver.find_element(css: 'h1') }.text
#   rescue Selenium::WebDriver::Error::TimeoutError
#     product.name = "Pas de nom"
#   end
#   puts product.name

# #   begin
# #     product.sku = wait.until { driver.find_element(css: 'div.grey-30-color > span:nth-child(1) > span:nth-child(2)').text }
# #   rescue Selenium::WebDriver::Error::TimeoutError
# #     product.sku = nil
# #   end
# #   puts product.sku

# #   begin
# #     product.ean = wait.until { driver.find_element(xpath: '//div[contains(@class, "grey-30-color")]/span[2]/span[2]').text.to_i }
# #   rescue Selenium::WebDriver::Error::TimeoutError
# #     product.ean = nil
# #   end
# #   puts product.ean

#   begin
#     img = wait.until { driver.find_element(css: '#catalog_product_view-media_gallery img').attribute('src') }
#     if img
#       product.link = img
#     end
#   rescue Selenium::WebDriver::Error::TimeoutError
#     product.link = "https://www.calculer.com/images/volume/carre.gif"
#   end
#   puts product.link

# #   # begin
# #   #   product.description = ''
# #   #   all_p = wait.until { driver.find_elements(css: '.d_none.tablet:d_block > p') }
# #   #   all_p.each do |p|
# #   #     product.description += p.text
# #   #   end
# #   # rescue Selenium::WebDriver::Error::TimeoutError
# #   #   product.description = "Pas de description"
# #   # end
# #   # puts product.description

# #   begin
# #     span_element = wait.until { driver.find_element(css: 'span.final-price.primary-color').text }
# #     match = span_element.match(/(\d+\.\d+)/)
# #     product.unit_price = match[1].to_f if match
# #     texte_apres_slash_match = span_element.match(/\/\s*(.+)/)
# #     product.unit = texte_apres_slash_match[1] if texte_apres_slash_match
# #   rescue Selenium::WebDriver::Error::TimeoutError
# #     product.unit_price = nil
# #     product.unit = nil
# #   end
# #   puts product.unit_price
# #   puts product.unit

#   begin
#     product.box = wait.until { driver.find_element(css: '.d_flex.ai-center.size-18.text-uppercase.m-b-1 > span:nth-child(2)').text }
#   rescue Selenium::WebDriver::Error::TimeoutError
#     product.box = nil
#   end
#   puts product.box

# #   begin
# #     element = wait.until { driver.find_element(xpath: '(//div[@class="d_flex ai-center col-gap-5"])[2]//span[1]').text }
# #     match = element.match(/(\d+\.\d+)/)
# #     product.price_per_unit = match[1].to_f if match
# #     match = element.match(/\/\s*(.+)/)
# #     product.mesure_unit = match[1] if match
# #   rescue Selenium::WebDriver::Error::TimeoutError
# #     product.price_per_unit = nil
# #     product.mesure_unit = nil
# #   end
# #   puts product.price_per_unit
# #   puts product.mesure_unit

# #   begin
# #     pourcentage_element = wait.until { driver.find_element(css: 'div.d_flex.ai-center.col-gap-5:nth-child(2) span.size-12.text-uppercase:nth-child(2) span:nth-child(2)').text }
# #     product.tva = pourcentage_element.gsub('%', '').to_f
# #   rescue Selenium::WebDriver::Error::TimeoutError
# #     product.tva = nil
# #   end
# #   puts product.tva

# #   begin
# #     match = wait.until { driver.find_element(css: '.d_flex.ai-center.col-gap-30.m-b-3.size-12 > span:nth-child(1)').text }
# #     match = match.match(/(\d+\.\d+)/)
# #     product.ht_box_price = match[1].to_f if match
# #   rescue Selenium::WebDriver::Error::TimeoutError
# #     product.ht_box_price = nil
# #   end
# #   puts product.ht_box_price

# #   begin
# #     match = wait.until { driver.find_element(css: '.d_flex.ai-center.col-gap-30.m-b-3.size-12 > span:nth-child(2)').text }
# #     match = match.match(/(\d+\.\d+)/)
# #     product.ttc_box_price = match[1].to_f if match
# #   rescue Selenium::WebDriver::Error::TimeoutError
# #     product.ttc_box_price = nil
# #   end
# #   puts product.ttc_box_price

#   product.brand = marque
#   product.category = Category.last

#   product.save!
#   puts "#{product.name} créé !"
# end


# brand = "Alphaform"
#   driver = Selenium::WebDriver.for :chrome, options: options
#   wait = Selenium::WebDriver::Wait.new(timeout: 7)
#   driver.navigate.to "https://www.centrale-ethnique.com/catalogsearch/result/?q=#{brand}"
#   driver.manage.timeouts.implicit_wait = 10
#   main_window = driver.window_handle

#   marque = Brand.last
#   # marque = Brand.create(name: brand)
#   links = wait.until { driver.find_elements(css: '.product_infos.text-center > a') }
#   links[24...29].each do |a|
# #   # links[12..23].each do |a|
# #   # links[19..28].each do |a|

#     driver.execute_script("window.open('#{a.attribute('href')}');")
#     driver.switch_to.window(driver.window_handles.last)
#     driver.manage.timeouts.implicit_wait = 5
#     create_product(driver, wait, marque)
#     driver.close
#     driver.switch_to.window(main_window)
#   end

#   driver.quit


# require "open-uri"

# products = Product.joins(:brand).where(brands: { name: "Nawhal's" })
# products.each do |prod|
#   file = URI.open(prod.link)
#   name = prod.name.gsub(' ', '_')
#   prod.photo.attach(io: file, filename: "#{name}.jpg", content_type: "image/jpg")
#   prod.save!
#   puts "#{prod.name} FAIT !!!"
# end

# p = Product.all
# p.each do |p|
#   p.update!(box: p.box.downcase)
#   puts p.box
# end

# ActiveRecord::Base.transaction do
#   duplicated_brand_names = Brand.group(:name).having("COUNT(*) > 1").pluck(:name)

#   duplicated_brand_names.each do |brand_name|
#     brands = Brand.where(name: brand_name)
#     first_brand = brands.first

#     brands.where.not(id: first_brand.id).each do |brand|
#       brand.products.update_all(brand_id: first_brand.id)
#       brand.destroy
#       puts "Transféré les produits de la marque #{brand.name} (ID: #{brand.id}) à la marque #{first_brand.name} (ID: #{first_brand.id}) et supprimé l'ancienne instance."
#     end
#   end
# end

# puts "Nettoyage des marques en double terminé."
