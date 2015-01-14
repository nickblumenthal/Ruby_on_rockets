require 'uri'
require 'deep_merge'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = route_params.merge(parse_www_encoded_form(req.query_string))
      @params = @params.merge(parse_www_encoded_form(req.body))
    end

    def [](key)
      @params[key.to_s]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      return {} if www_encoded_form.nil?
      result_hash = {}
      results_ary = URI.decode_www_form(www_encoded_form)
      results_ary.each do |key_arr, val|
        keys = parse_key(key_arr)
        single_hash = keys.reverse.inject(val) { |a, e| { e => a } }
        # byebug if www_encoded_form == "user[address][street]=main&user[address][zip]=89436"
        result_hash.deep_merge!(single_hash)
      end

      result_hash
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      keys = key.split(/\]\[|\[|\]/)
    end
  end
end
