require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require './lib/steps'
require './lib/steps/get_template'
require './lib/steps/get_url'
require './lib/steps/get_to_signin'

prompt = TTY::Prompt.new
agent = Mechanize.new

markdown = Steps::GetTemplate.new(prompt).call
# url = Steps::GetUrl.new(prompt).call
url = 'https://capsens.githost.io'
puts "byepass get URL FOR DEV"
dunno = Steps::GetToSignin.new(prompt, agent, url).call

