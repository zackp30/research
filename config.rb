###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload, host: 'localhost'
end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript
end

# after_configuration do
#   if defined?(RailsAssets)
#     RailsAssets.load_paths.each do |path|
#       sprockets.append_path path
#     end
#   end
# end

require 'onebox'

helpers do
  $json = JSON.parse File.read 'terms.json'
  def toolt(title, contents)
    "<span class=\"tooltip\" title=\"#{title}\">#{contents}</span>"
  end

  def onetoolt(url, contents)
    "<span class=\"tooltip\" title=\"#{Onebox.preview(url).to_s.gsub(/"/, "'")}\">#{contents}</span>"
  end

  def lookup_term(term)
    $json.select { |j| j['name'].downcase == term.downcase ? j['contents'] : nil }[0]['contents']
  end
  def toolterm(term, contents)
    toolt lookup_term(term), contents
  end
end

set :markdown_engine, :redcarpet
set :markdown, parse_block_html: true

activate :syntax

class WebpackM < Middleman::Extension
  def initialize(app, options_hash={}, &block)
    super
    app.after_build do |builder|
      builder.thor.run 'webpack'
    end
  end
end

::Middleman::Extensions.register(:webpackm, WebpackM)

activate :webpackm

ignore "javascripts/main.es6.js"
ignore "vendor"
