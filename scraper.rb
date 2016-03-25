require 'rubygems'
require 'nokogiri'
require 'restclient'
require 'json'

# page url we wish to scrape
PAGE_URL = "https://www.vocabulary.com/lists/191545"

# output file name, in this case json format
OUTPUT_FILE = "words.json"

# make a get request to our url
# convert the response to html
page = Nokogiri::HTML(RestClient.get(PAGE_URL))

# each list element has our word and definition
word_group = page.css('li').select()

# create a hash to store our word, definition pairs
words = []

# get each word, definition and insert into hash
word_group.each do |group|

	word_group = {}

	word =  group.css('.word').text.to_s
	definition = group.css('.definition').text.to_s

	if(word != "" && definition != "")
		word_group[word] = definition
		words.push(word_group)
	end

end

output_hash = {}
output_hash['data'] = words

# finally, write our hash to a json file 
File.open(OUTPUT_FILE,"w") do |f|
  f.write(output_hash.to_json)
end