class ReadLinkService
  attr_reader :link_title,
              :link_url,
              :link_user,
              :link_created_at

  def initialize(link)
    @link_title      = link.title
    @link_url        = link.url
    @link_user       = link.user_id
    @link_created_at = link.created_at
  end

  def conn
    Faraday.new(url: 'https://hot-reads-jh.herokuapp.com') do |faraday|
      faraday.adapter  Faraday.default_adapter
    end
  end

  def send_read_receipt
    conn.post do |req|
      req.url                       '/reads'
      req.params['link_title']      = link_title
      req.params['link_url']        = link_url
      req.params['link_user']       = link_user
      req.params['link_created_at'] = link_created_at
    end
  end
end
