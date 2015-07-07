require 'watir-webdriver'
require 'selenium-webdriver'
require 'rubygems'
require "rspec"
require "watir-scroll"

require_relative "Chrome_Liverail_Suite"
require_relative "Firefox_Liverail_Suite"
require_relative "IE_Liverail_Suite"

Thread.new{Chrome_Liverail_Suite}
Thread.new{Firefox_Liverail_Suite}
Thread.new{IE_Liverail_Suite}