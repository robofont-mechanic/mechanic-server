xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    @extensions.each do |extension|
      xml.title extension.name
      xml.pubDate Time.parse(extension.created_at.to_s).rfc822
      xml.link 'http://github.com/' + extension.repository
      xml.guid extension.id
      xml.description extension.description
    end
  end
end
