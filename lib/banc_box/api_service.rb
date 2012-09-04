module BancBox
  module ApiService
    def formatted_time(time)
      time && time.strftime('%Y-%m-%dT%H:%M:%S')
    end

    def formatted_date(date)
      date && date.strftime('%Y-%m-%d')
    end

    def boolean_to_yes_no(bool)
      bool ? 'YES' : 'NO'
    end

    def get_response(method, endpoint, data)
      response = BancBox.connection.__send__(method, endpoint, data)
      if response['errors'] != nil
        raise BancBox::Error.new(response['errors'])
      end
      response
    end

    def object_from_response(klass, method, endpoint, data, key)
      klass.from_response(get_response(method, endpoint, data)[key])
    end

    def collection_from_response(klass, method, endpoint, data, key)
      get_response(method, endpoint, data)[key.to_s].map do |i|
        klass.from_response(i)
      end
    end
  end
end
