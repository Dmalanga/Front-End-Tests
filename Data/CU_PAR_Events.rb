require "rubygems"
require "selenium-webdriver"
require "watir-webdriver"
require "rspec"
require "headless"







uniqueView = "http://gmpx.bzgint.com/collectorx/american_media/DENNIS-1234567?dl=/qa_sprinttesting/sprint44/collectorx/cu_testpage_2.html&sid=8F78E0AD-66AD-48F5-B63A-DENNISTEST10&rs=qa.contentunlock.s3.amazonaws.com&sd=1&fvd=0&pug=0&pru=0&ppu=0&ckw=default&br=Chrome35&os=Windows&cty=IT&lt=0&evt=uv&adId=5192726&ts=1403202298487"
scriptInitiated = "http://gmpx.bzgint.com/collectorx/american_media/DENNIS-1234567?dl=/qa_sprinttesting/sprint44/collectorx/cu_testpage_2.html&sid=8F78E0AD-66AD-48F5-B63A-DENNISTEST10&rs=qa.contentunlock.s3.amazonaws.com&sd=1&fvd=0&pug=0&pru=0&ppu=0&ckw=default&br=Chrome35&os=Windows&cty=IT&lt=0&evt=si&adId=5192726&ts=1403202298487"
pageWillLock = "http://gmpx.bzgint.com/collectorx/american_media/DENNIS-1234567?dl=/qa_sprinttesting/sprint44/collectorx/cu_testpage_2.html&sid=8F78E0AD-66AD-48F5-B63A-DENNISTEST10&rs=qa.contentunlock.s3.amazonaws.com&sd=1&fvd=0&pug=0&pru=0&ppu=0&ckw=default&br=Chrome35&os=Windows&cty=IT&lt=0&evt=pwl&adId=5192726&ts=1403202298487"
adsLoaded = "http://gmpx.bzgint.com/collectorx/american_media/DENNIS-1234567?dl=/qa_sprinttesting/sprint44/collectorx/cu_testpage_2.html&sid=8F78E0AD-66AD-48F5-B63A-DENNISTEST10&rs=qa.contentunlock.s3.amazonaws.com&sd=1&fvd=0&pug=0&pru=0&ppu=0&ckw=default&br=Chrome35&os=Windows&cty=IT&lt=0&evt=al&adId=5192726&ts=1403202298487"
pageDidLock = "http://gmpx.bzgint.com/collectorx/american_media/DENNIS-1234567?dl=/qa_sprinttesting/sprint44/collectorx/cu_testpage_2.html&sid=8F78E0AD-66AD-48F5-B63A-DENNISTEST10&rs=qa.contentunlock.s3.amazonaws.com&sd=1&fvd=0&pug=0&pru=0&ppu=0&ckw=default&br=Chrome35&os=Windows&cty=ITfv&lt=0&evt=pdl&adId=5192726&ts=1403202298487"
adPlaybackStarted = "http://gmpx.bzgint.com/collectorx/american_media/DENNIS-1234567?dl=/qa_sprinttesting/sprint44/collectorx/cu_testpage_2.html&sid=8F78E0AD-66AD-48F5-B63A-DENNISTEST10&rs=qa.contentunlock.s3.amazonaws.com&sd=1&fvd=0&pug=0&pru=0&ppu=0&ckw=default&br=Chrome35&os=Windows&cty=IT&lt=0&evt=aps&adId=5192726&ts=1413389258306&aut=true&tpc=cu"
adSkipped = "http://gmpx.bzgint.com/collectorx/american_media/DENNIS-1234567?dl=/qa_sprinttesting/sprint44/collectorx/cu_testpage_2.html&sid=8F78E0AD-66AD-48F5-B63A-DENNISTEST10&rs=qa.contentunlock.s3.amazonaws.com&sd=1&fvd=0&pug=0&pru=0&ppu=0&ckw=default&br=Chrome35&os=Windows&cty=IT&lt=0&evt=as&adId=5192726&ts=1403202298487"
adCompleted = "http://gmpx.bzgint.com/collectorx/american_media/DENNIS-1234567?dl=/qa_sprinttesting/sprint44/collectorx/cu_testpage_2.html&sid=8F78E0AD-66AD-48F5-B63A-DENNISTEST10&rs=qa.contentunlock.s3.amazonaws.com&sd=1&fvd=0&pug=0&pru=0&ppu=0&ckw=default&br=Chrome35&os=Windows&cty=IT&lt=0&evt=ac&adId=5192726&ts=1403202298487"
pageDidUnlock = "http://gmpx.bzgint.com/collectorx/american_media/DENNIS-1234567?dl=/qa_sprinttesting/sprint44/collectorx/cu_testpage_2.html&sid=8F78E0AD-66AD-48F5-B63A-DENNISTEST10&rs=qa.contentunlock.s3.amazonaws.com&sd=1&fvd=0&pug=0&pru=0&ppu=0&ckw=default&br=Chrome35&os=Windows&cty=IT&lt=0&evt=pdl&adId=5192726&ts=1403202298487"


list = [uniqueView, scriptInitiated, pageWillLock, adsLoaded, pageDidLock, adPlaybackStarted, adCompleted, pageDidUnlock]


chrome = Watir::Browser.new :chrome
50.times {list.each {|event| chrome.goto event}}
chrome.quit


firefox = Watir::Browser.new :firefox
50.times {list.each {|event| firefox.goto event}}
firefox.quit

ie = Watir::Browser.new :ie
50.times {list.each {|event| ie.goto event}}
ie.quit