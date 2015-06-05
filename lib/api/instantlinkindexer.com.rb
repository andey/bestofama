class InstantLinkIndexer
  include HTTParty
  base_uri 'www.instantlinkindexer.com'

  def submit
    urls = []
    Ama.select(:key).order('random()').limit(100).each do |ama|
      urls.append "https://bestofama.com/amas/#{ama.key}"
    end

    options = {
        query: {
            apikey: ENV['INSTANT_LINK_INDEXER'],
            cmd: 'submit',
            urls: urls.join('|')
        }
    }
    response = self.class.post('/api.php', options)
    ap response.body
    return
  end
end