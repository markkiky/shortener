# frozen_string_literal: true

module Links
  # This job fetches the head of a submitted URl and validates its accuracy
  class HeadJob
    include Sidekiq::Job

    def perform(link_id)
      link = Link.find(link_id)

      url_service = UrlParserService.new(link.url)
      response = url_service.fetch_head
    rescue SocketError, Errno::ENONET
      link.validated = false
      link.save
    rescue StandardError => e
      print("Failed to perform HeadJob: #{e.message}")
    else
      link.title = response[:title]
      link.favicon = response[:favicon]
      link.validated = true
      link.save
    end
  end
end
