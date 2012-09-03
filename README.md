# BancBox #
A Ruby wrapper for BancBox's REST API.

## <a name="installation"></a>Install
    gem install banc_box

## <a name="configuration"></a>Configure

    require 'banc_box'

    BancBox.configure do |config|
      config.api_key = API_KEY
      config.api_secret = API_SECRET
      config.base_url = BANCBOX_BASE_URL
      config.subscriber_id = SUBSCRIBER_ID
    end

## <a name="usage"></a>Use

You can then access data through BancBox::Client.

## <a name="documentation"></a>Learn
[http://rdoc.info/github/aub/banc_box][documentation]

[documentation]: http://rdoc.info/github/aub/banc_box

## <a name="copyright"></a>Copyright
Copyright (c) 2012 Aubrey Holland
See [LICENSE][] for details.

[license]: https://github.com/aub/banc_box/blob/master/LICENSE.md

