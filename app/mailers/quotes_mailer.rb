class QuotesMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.quotes_mailer.send_quote.subject
  #
  def send_quote(quote)
    @quote = Quote.find(quote[:id])
    @quote_items = @quote.quote_items.includes(product: [:category, :brand]).sort_by { |item|
      [item.product.category.name, item.product.brand.name]
    }
    @products = @quote.products

    mail(to: "commande@makhfoodmarket.fr", subject: "Demande devis n° #{@quote.id}")
  end
end
