require 'twitter'


#### Get your twitter keys & secrets:
#### https://dev.twitter.com/docs/auth/tokens-devtwittercom
twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = 'hn5BjfWML1YZoNnaFR9SN0L5V'
  config.consumer_secret = 'QFNTSqFv36xsZV6wnLyYrgadCaDNxYLjw4iplCCIFXdyhfBGeF'
  config.access_token = '46338610-Q0DoJRedF95qDOxuN4G5oNeVANzJIjXGqKh1COe70'
  config.access_token_secret = 'TwCGbPvnnhpaKM7O1mLK2KeC1f1bADKFVKWwdszu3lN56'
end

search_term = URI::encode('madisonbubbler')

SCHEDULER.every '10m', :first_in => 0 do |job|
  begin
    tweets = twitter.search("#{search_term}")

    if tweets
      tweets = tweets.map do |tweet|
        { name: tweet.user.name, body: tweet.text, avatar: tweet.user.profile_image_url_https }
      end
      send_event('twitter_mentions', comments: tweets)
    end
  rescue Twitter::Error
    puts "\e[33mFor the twitter widget to work, you need to put in your twitter API keys in the jobs/twitter.rb file.\e[0m"
  end
end