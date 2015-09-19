require 'webmock/minitest'

WebMock.disable_net_connect!(allow: %w{codeclimate.com})
