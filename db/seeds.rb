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

# Spécifiez le chemin vers le ChromeDriver si ce n'est pas dans votre PATH
Selenium::WebDriver::Chrome::Service.driver_path = "/home/adam/chromedriver-linux64/chromedriver"

# Créez une instance du navigateur Chrome
options = Selenium::WebDriver::Chrome::Options.new
driver = Selenium::WebDriver.for :chrome, options: options

driver.navigate.to 'https://www.centrale-ethnique.com/tous-les-produits/03683-nval'
driver.manage.timeouts.implicit_wait = 10

product = Product.new
product.name = driver.find_element(:tag_name, 'h1').text

product.sku = driver.find_element(css: 'div.grey-30-color > span:nth-child(1) > span:nth-child(2)').text

product.ean = driver.find_element(xpath: '//div[contains(@class, "grey-30-color")]/span[2]/span[2]').text.to_i

img = driver.find_element(xpath: '//*[@id="catalog_product_view-media_gallery"]//img').attribute('src')
file = URI.open(img)
product.photo.attach(io: file, filename: "#{product.name.gsub(" ", "_")}.jpg", content_type: "image/jpg")

span_element = driver.find_element(css: 'span.final-price.primary-color').text
match = span_element.match(/(\d+\.\d+)/)
product.unit_price = match[1].to_f if match

texte_apres_slash_match = span_element.match(/\/\s*(.+)/)
product.unit = texte_apres_slash_match[1] if texte_apres_slash_match

product.box = driver.find_element(css: '.d_flex.ai-center.size-18.text-uppercase.m-b-1 > span:nth-child(2)').text

element = driver.find_element(xpath: '(//div[@class="d_flex ai-center col-gap-5"])[2]//span[1]').text
match = element.match(/(\d+\.\d+)/)
product.price_per_unit = match[1].to_f if match

match = element.match(/\/\s*(.+)/)
product.mesure_unit = match[1] if match
pourcentage_element = driver.find_element(css: 'div.d_flex.ai-center.col-gap-5:nth-child(2) span.size-12.text-uppercase:nth-child(2) span:nth-child(2)').text
product.tva = pourcentage_element.gsub('%', '').to_f


match = driver.find_element(css: '.d_flex.ai-center.col-gap-30.m-b-3.size-12 > span:nth-child(1)').text
match = match.match(/(\d+\.\d+)/)
product.ht_box_price = match[1].to_f if match

match = driver.find_element(css: '.d_flex.ai-center.col-gap-30.m-b-3.size-12 > span:nth-child(2)').text
match = match.match(/(\d+\.\d+)/)
product.ttc_box_price = match[1].to_f if match

product.save!
puts "#{product.name} créé !"
# Assurez-vous d'abord que vous avez configuré et initialisé votre instance de WebDriver (driver) correctement.

# Identifiez l'élément <li> que vous souhaitez cliquer (par exemple, "Caractéristiques")
# li = driver.find_element(xpath: '//span[contains(@class, "weight-600") and contains(@class, "size-18") and contains(@class, "p-b-1") and contains(@class, "cursor-pointer") and contains(@class, "d_block") and contains(@class, "tablet:d_inline-block") and contains(@class, "m-b-2") and contains(@class, "border-b-2") and contains(@class, "border-solid") and contains(@class, "border-text") and contains(@class, "tablet:border-white")]
# ')
# li.click()
# driver.manage.timeouts.implicit_wait = 10
# description = driver.find_element(css: '.p-b-3.d_block > div > p').text
# p description

# li = driver.find_element(xpath: '//span[contains(@class, "weight-600") and contains(@class, "size-18") and contains(@class, "p-b-1") and contains(@class, "cursor-pointer") and contains(@class, "d_block") and contains(@class, "tablet:d_inline-block") and contains(@class, "m-b-2") and contains(@class, "border-b-2") and contains(@class, "border-solid") and contains(@class, "border-text") and contains(@class, "tablet:border-white")]
# ')
# li.click()
# driver.manage.timeouts.implicit_wait = 10
# specification = driver.find_element(css: '.p-b-3.d_block > div > p').text
# p specification

# li = driver.find_element(xpath: '(//span[contains(@class, "weight-600") and contains(@class, "size-18") and contains(@class, "p-b-1") and contains(@class, "cursor-pointer") and contains(@class, "d_block") and contains(@class, "tablet:d_inline-block") and contains(@class, "m-b-2") and contains(@class, "border-b-2") and contains(@class, "border-solid") and contains(@class, "border-text") and contains(@class, "tablet:border-white")])[2]')
# li.click()
# driver.manage.timeouts.implicit_wait = 10
# conditionning = driver.find_element(css: '.p-b-3.d_block > div > p').text
# p conditionning

driver.quit

#           conditionning:"Bouteille de 32cL
#           24 bouteilles / fardeau
#           72 fardeaux / palette
#           8 fardeaux / couche
#           9 couches / palette")







# Créez une instance du navigateur web (par exemple, Chrome)

# product_price = doc.text.match(/"final_price":([^,]+),/)&.captures&.first
# puts product_price

# product_name_match = doc.text.match(/"label":"([^"]+)"/)
# product_name = product_name_match&.captures&.first

# # Affiche le nom du produit
# puts product_name

# ean = doc.text.match(/"ean":"([^"]+)"/)&.captures&.first
# puts ean

# Trouve la partie du code JavaScript que tu veux analyser
# script_content = doc.match(/<script type="text\/x-magento-init">(.*?)<\/script>/m)[1]

# # Analyse le JSON contenu dans le code JavaScript
# data = JSON.parse(script_content)

# # Extrait le nom du produit
# product_name = data.dig('*', 'Magento_Catalog/js/product/view/provider', 'data', 'items', '15538', 'name')

# puts "Nom du produit : #{product_name}"

# name = doc.at_css('h1 span')
# p name
# product.name = doc.at_css('h1 span').text
# product.sku = doc.css(".size-12.text-uppercase.m-r-1 span")[1].text
# product.ean = doc.at_css(".d_flex.ai-center.col-gap-5 > .grey-30-color > size-12 text-uppercase")[1].at_css("span")[1].text.to_i
# product.save!


# deuxieme_span_text = doc.css('.class1 span')[1].text


# product = Product.new(
#           name: "MOGU MOGU Melon 32cL",
#           sku: "02976AMAX",
#           ean: 8850389111366,
#           unit_price: 0.797,
#           unit: "Col",
#           box: "CARTON 320ML X24",
#           price_per_unit: 2.4906,
#           mesure_unit: "L",
#           tva: 5.5,
#           ht_box_price: 19.128,
#           ttc_box_price:20.18,
#           description:"Le Mogu Mogu melon est une boisson originale à base de jus de litchi et cubes de gelées d'eau de coco appelées 'nata' qui apportent du croquant. Cette référence est disponible au format bouteille de 32cL x 24 / fardeau.",
#           specification:"Bouteille de 32cL
#           Boisson originale à base de jus de fruit de melon et morceaux de nata (cubes d'eau de noix de coco en gelée)
#           À conserver dans un endroit frais et sec, à l'abri de la lumière",
#           conditionning:"Bouteille de 32cL
#           24 bouteilles / fardeau
#           72 fardeaux / palette
#           8 fardeaux / couche
#           9 couches / palette")
# file = URI.open("https://www.centrale-ethnique.com/media/catalog/product/0/2/02976_mogumogu_melon_32cl_1.jpg")
# product.photo.attach(io: file, filename: "#{product.name.gsub(" ", "_")}.jpg", content_type: "image/jpg")
# product.save!
