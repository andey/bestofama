xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "BestofAMA"
    xml.description "directory and archive of popular reddit.com “Ask me Anythings”"
    xml.link amas_url

    for ama in @amas
      xml.item do
        xml.title ama.title
        xml.description ama.content
        xml.pubDate ama.date.to_s(:rfc822)
        xml.link ama_url(ama)
        xml.guid ama_url(ama)
      end
    end
  end
end