require 'time'
require 'cgi'
require 'digest'
require 'base64'
require 'openssl'
require 'net/http'

class KissMWS
  def self.send_feed(data, configuration)
    #setup query string
    params = {
     'AWSAccessKeyId'      => configuration[:aws_access_key_id],
     'Action'              => 'SubmitFeed',
     'Merchant'            => configuration[:seller_id],
     'SignatureVersion'    => 2,
     'Timestamp'           => Time.now.iso8601,
     'Version'             => '2009-01-01',
     'SignatureMethod'     => 'HmacSHA256',
     'FeedType'            => '_POST_FLAT_FILE_PRICEANDQUANTITYONLY_UPDATE_DATA_',
     'MarketplaceIdList.Id.1' =>  configuration[:marketplace_id],
     'PurgeAndReplace'     => false
    }
    params['Signature']   =  Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha256'),
                                        configuration[:secret_access_key],
                                        "POST\n#{configuration[:amazon_url]}\n/\n#{canonical_querystring(params)}")).strip

    #setup request
    http = Net::HTTP.new(configuration[:amazon_url], 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new("/?#{canonical_querystring(params)}")
    request.body = "sku\tprice\tquantity" << data.map { |item| "\n#{item[0]}\t#{item[1]}\t#{item[2]}" }.join
    request['Content-Type'] = 'text/xml'
    request['Content-MD5']  = [[Digest::MD5.hexdigest(request.body)].pack("H*")].pack("m").strip

    http.request(request)
  end

  def self.canonical_querystring(params)
    params.sort.collect { |key, value| [CGI.escape(key.to_s), CGI.escape(value.to_s)].join('=') }.join('&')
  end
end
