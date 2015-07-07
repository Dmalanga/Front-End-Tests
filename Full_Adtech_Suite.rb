require 'watir-webdriver'
require 'selenium-webdriver'
require 'rubygems'
require "rspec"
require "watir-scroll"

require_relative "IE_Adtech_Suite"
require_relative "Firefox_Adtech_Suite"
require_relative "Chrome_Adtech_Suite"

Thread.new{IE_Suite}
Thread.new{Firefox_Suite}
Thread.new{Chrome_Suite}