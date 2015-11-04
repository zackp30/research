require 'json'
require 'media_wiki'

class Element

  def initialize(name)
    @name = name
    @id = Element.determine_id(name) || fail('Element does not exist.')
    @picture = picture
  end

  def picture
    c = MediaWiki::Gateway.new("http://minecraft.gamepedia.com/api.php")
    c.image_info("#{@name}.png", 'iiprop' => ['url'])['url']
  end

  def self.parse
    return JSON.parse File.read 'items.json' unless defined?(@json)
    @json
  end

  def self.determine_id(name)
    a = parse.select { |j| j['name'].downcase == name.downcase ? j['type'] : nil }
    return nil unless a # don't want an empty list in return
    a[0]['type']
  end

  def tooltip(contents)
    box = "#{@name} (#{@id})<br/><img src=\"#{@picture}\"/>"
    "<span class='tooltip' title='#{box}'>#{contents}</span>"
  end
end
