class QuotesMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.quotes_mailer.send_quote.subject
  #
  def send_quote
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
