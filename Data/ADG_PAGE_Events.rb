require "rubygems"
require "selenium-webdriver"
require "watir-webdriver"
require "rspec"
require "headless"

require_relative "ADG_Event_Declaration"

$pvid = "70B3AA54-EA4D-45F1-9EFD-DDDDD2222SSF"
$ssid = "41E18495-AF2F-4486-BC0B-D8925569699E"
$uid = "1FB2C29B-352F-415D-B3F9-DDDDDDDDDDDD"
$domain = "qa.contentunlock.s3.amazonaws.com"
$url = "http://dennis.backend.gap1.8.com"
$browser = "Chrome"
$browser_version = "42"
$device = "desktop"
$session_depth = "2"
$os = "Windows"
$language = "en-US"
$returning_user = "true"
$referral_source = "direct"
$session_referral = "direct_too"
$audience = "47129|53011|54667|68025|99999|88888"
$latitude = "40.7391" 
$longitude = "-73.9826" 
$country = "GER" 
$region = "New York" 
$city = "New York" 
$ip_address = "50.75.193.138" 
$site_id = "Dennis_Test" 
$intercept_id = "1001" 
$autoplay = "false" 
$mute_on_autoplay = "true" 
$passback_enabled = "false" 
$skip_time = "15" 
$free_view_reason = "" 
$ad_id = "123456" 
$visible_duration = "" 
$playback_duration = "" 
$timestamp = "" 
$bn_id = ""
$atsop = "20"



events
event_list = [$data_tag_loaded]

chrome = Watir::Browser.new :chrome
1.times {event_list.each {|event| chrome.goto event}}
chrome.quit

# 10.times {event_list.each {|event| puts event}}