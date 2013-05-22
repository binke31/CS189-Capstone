require 'rubygems'
require 'bundler/setup'

require 'active_resource'


#SITE = "http://10.2.201.19:4000"
SITE = "https://capstone3.qa.appfolio.com/connect/"

class CapstonePayment < ActiveResource::Base
  self.site = SITE
end