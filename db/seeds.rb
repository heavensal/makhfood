# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'selenium-webdriver'
Product.destroy_all
# Spécifiez le chemin vers le ChromeDriver si ce n'est pas dans votre PATH
Selenium::WebDriver::Chrome::Service.driver_path = "/home/adam/chromedriver-linux64/chromedriver"

# Créez une instance du navigateur Chrome
options = Selenium::WebDriver::Chrome::Options.new
driver = Selenium::WebDriver.for :chrome, options: options
wait = Selenium::WebDriver::Wait.new(timeout: 7)

def create_product(driver, wait)
  product = Product.new

  begin
    product.name = wait.until { driver.find_element(:tag_name, 'h1') }.text
  rescue Selenium::WebDriver::Error::TimeoutError
    product.name = nil
  end
  puts product.name if product.name

  begin
    product.sku = wait.until { driver.find_element(css: 'div.grey-30-color > span:nth-child(1) > span:nth-child(2)').text }
  rescue Selenium::WebDriver::Error::TimeoutError
    product.sku = nil
  end

  begin
    product.ean = wait.until { driver.find_element(xpath: '//div[contains(@class, "grey-30-color")]/span[2]/span[2]').text.to_i }
  rescue Selenium::WebDriver::Error::TimeoutError
    product.ean = nil
  end

  begin
    img = wait.until { driver.find_element(xpath: '//*[@id="catalog_product_view-media_gallery"]//img').attribute('src') }
    if img
      product.link = img
    end
  rescue Selenium::WebDriver::Error::TimeoutError
    product.link = nil
  end

  begin
    span_element = wait.until { driver.find_element(css: 'span.final-price.primary-color').text }
    match = span_element.match(/(\d+\.\d+)/)
    product.unit_price = match[1].to_f if match
    texte_apres_slash_match = span_element.match(/\/\s*(.+)/)
    product.unit = texte_apres_slash_match[1] if texte_apres_slash_match
  rescue Selenium::WebDriver::Error::TimeoutError
    product.unit_price = nil
    product.unit = nil
  end

  begin
    product.box = wait.until { driver.find_element(css: '.d_flex.ai-center.size-18.text-uppercase.m-b-1 > span:nth-child(2)').text }
  rescue Selenium::WebDriver::Error::TimeoutError
    product.box = nil
  end

  begin
    element = wait.until { driver.find_element(xpath: '(//div[@class="d_flex ai-center col-gap-5"])[2]//span[1]').text }
    match = element.match(/(\d+\.\d+)/)
    product.price_per_unit = match[1].to_f if match
    match = element.match(/\/\s*(.+)/)
    product.mesure_unit = match[1] if match
  rescue Selenium::WebDriver::Error::TimeoutError
    product.price_per_unit = nil
    product.mesure_unit = nil
  end

  begin
    pourcentage_element = wait.until { driver.find_element(css: 'div.d_flex.ai-center.col-gap-5:nth-child(2) span.size-12.text-uppercase:nth-child(2) span:nth-child(2)').text }
    product.tva = pourcentage_element.gsub('%', '').to_f
  rescue Selenium::WebDriver::Error::TimeoutError
    product.tva = nil
  end

  begin
    match = wait.until { driver.find_element(css: '.d_flex.ai-center.col-gap-30.m-b-3.size-12 > span:nth-child(1)').text }
    match = match.match(/(\d+\.\d+)/)
    product.ht_box_price = match[1].to_f if match
  rescue Selenium::WebDriver::Error::TimeoutError
    product.ht_box_price = nil
  end

  begin
    match = wait.until { driver.find_element(css: '.d_flex.ai-center.col-gap-30.m-b-3.size-12 > span:nth-child(2)').text }
    match = match.match(/(\d+\.\d+)/)
    product.ttc_box_price = match[1].to_f if match
  rescue Selenium::WebDriver::Error::TimeoutError
    product.ttc_box_price = nil
  end

  product.save!
  puts "#{product.name} créé !"
end



driver.navigate.to 'https://www.centrale-ethnique.com/tous-les-produits'
driver.manage.timeouts.implicit_wait = 10
main_window = driver.window_handle

loop do

  num_links = driver.find_elements(css: '.text-center.m-t-2 > a').length
  num_links.times do |i|
    links = driver.find_elements(css: '.text-center.m-t-2 > a')
    driver.execute_script("window.open('#{links[i].attribute('href')}');")
    driver.switch_to.window(driver.window_handles.last)
    driver.manage.timeouts.implicit_wait = 5
    create_product(driver, wait)
    driver.close
    driver.switch_to.window(main_window)
  end

  # Mise à jour et vérification du bouton "Suivant"
  next_buttons = driver.find_elements(xpath: '//*[local-name()="svg" and contains(@class, "w-20p h-20p")]')
  if next_buttons.length > 1
    next_button = next_buttons[1]
    next_button.click
    puts "page suivante !"
  else
    break # Sortir de la boucle si aucun bouton "Suivant"
  end

end

driver.quit
