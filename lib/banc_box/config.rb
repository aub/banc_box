module BancBox
  module Config
    def self.base_url=(url)
      @base_url = url
    end

    def self.base_url
      @base_url
    end

    def self.subscriber_id=(id)
      @subscriber_id = id
    end

    def self.subscriber_id
      @subscriber_id
    end

    def self.api_key=(key)
      @api_key = key
    end

    def self.api_key
      @api_key
    end

    def self.api_secret=(secret)
      @api_secret = secret
    end

    def self.api_secret
      @api_secret
    end
  end
end
