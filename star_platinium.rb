require 'rubygems'
require 'bundler/setup'
require 'json'

Bundler.require(:default)

require './lib/steps'
require './lib/steps/get_template'
require './lib/steps/get_url'
require './lib/steps/signin'
require './lib/steps/get_group'

prompt = TTY::Prompt.new
agent = Mechanize.new

markdown = Steps::GetTemplate.new(prompt).call
# url = Steps::GetUrl.new(prompt).call
url = 'https://capsens.githost.io'
puts "byepass get URL FOR DEV"
page = Steps::Signin.new(prompt, agent, url).call
path = Steps::GetGroup.new(prompt, agent, url).call
puts path.inspect
