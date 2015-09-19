require_relative 'webmock'

class AddFeatureMocker
  include WebMock::API

  def run
    return unless url && page_title

    stub_request(:any, url).to_return(
      body: html_body,
      status: 200,
      headers: { 'Content-Type': 'text/html' }
    )
  end

  def url
    ENV['WEB_MOCK_URL']
  end

  def page_title
    ENV['WEB_MOCK_PAGE_TITLE']
  end

  def html_body
    <<-HTML
    <!DOCTYPE html>
    <html>
      <head>
        <title>#{page_title}</title>
      </head>

      <body>
      </body>
    </html>
    HTML
  end
end
