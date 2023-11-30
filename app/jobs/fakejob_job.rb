class FakejobJob < ApplicationJob
  queue_as :default

  def perform(*arg)
    puts 'hello from job'
  end
end
