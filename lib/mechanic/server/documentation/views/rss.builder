xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.title "Robofont Mechanic"
    xml.description "A feed of Robofont extensions managed by Mechanic"
    xml.link request.url
    @extensions.each do |extension|
      xml.item do
        xml.title "#{extension.name} by #{extension.author}"
        xml.pubDate Time.parse(extension.created_at.to_s).rfc822
        xml.link 'http://github.com/' + extension.repository
        xml.guid('robofont-mechanic-' + extension.id.to_s, { isPermaLink: false })
        xml.description 'By %s: %s' % [extension.author, extension.description]
      end
    end
  end
end
