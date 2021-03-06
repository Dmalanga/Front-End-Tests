require "rubygems"
require "selenium-webdriver"
require "watir-webdriver"
require "rspec"
require "headless"


#Data Tag Parameters
$pvid = ""
$ssid = ""
$uid = ""
$latitude = "" 
$longitude = "" 
$country = "" 
$region = "" 
$city = "" 
$ip_address = "" 
$atsop = "" 
$audience = "" 
$device = "" 
$returning_user = "" 
$language = "" 
$referral_source = "" 
$session_referral = "" 
$domain = "" 
$session_depth = "" 
$os = "" 

#ADG Tag Parameters
$site_id = "" 
$url = "" 
$intercept_id = "" 
$autoplay = "" 
$mute_on_autoplay = "" 
$passback_enabled = "" 
$browser = "" 
$browser_version = "" 
$skip_time = "" 
$free_view_reason = "" 
$ad_id = "" 
$visible_duration = "" 
$playback_duration = "" 
$timestamp = "" 
$bn_id = ""

def events
	$data_tag_loaded = "http://54.152.2.180:8080/CollectorxQA/qa.contentunlock.s3.amazonaws.com/data/?evt=dtl&tpc=adg&dn=#{$domain}&url=#{$url}&br=#{$browser}&dv=#{$device}&bv=#{$browser_version}&pvid=#{$pvid}&ssid=#{$ssid}&ssd=#{$session_depth}&os=#{$os}&lang=#{$language}&rf=#{$referral_source}&ssrf=#{$session_referral}"
	$page_scrolled = "http://54.152.2.180:8080/CollectorxQA/qa.contentunlock.s3.amazonaws.com/data/?evt=psc&tpc=adg&dn=#{$domain}&url=#{$url}&br=#{$browser}&dv=#{$device}&bv=#{$browser_version}&pvid=#{$pvid}&ssid=#{$ssid}&uid=#{$uid}&ssd=#{$session_depth}&os=#{$os}&lang=#{$language}&rf=#{$referral_source}&ssrf=#{$session_referral}"
	$page_unloaded = "http://54.152.2.180:8080/CollectorxQA/qa.contentunlock.s3.amazonaws.com/data/?evt=x&tpc=adg&dn=#{$domain}&url=#{$url}&br=#{$browser}&dv=#{$device}&bv=#{$browser_version}&pvid=#{$pvid}&ssid=#{$ssid}&uid=#{$uid}&ssd=#{$session_depth}&os=#{$os}&lang=#{$language}&rf=#{$referral_source}&ssrf=#{$session_referral}&atsop=#{$atsop}"
	$page_clicked = "http://54.152.2.180:8080/CollectorxQA/qa.contentunlock.s3.amazonaws.com/data/?evt=pck&tpc=adg&dn=#{$domain}&url=#{$url}&br=#{$browser}&dv=#{$device}&bv=#{$browser_version}&pvid=#{$pvid}&ssid=#{$ssid}&uid=#{$uid}&ssd=#{$session_depth}&os=#{$os}&lang=#{$language}&rf=#{$referral_source}&ssrf=#{$session_referral}"
	$audience_loaded = "http://54.152.2.180:8080/CollectorxQA/qa.contentunlock.s3.amazonaws.com/data/?evt=aul&tpc=adg&dn=#{$domain}&url=#{$url}&br=#{$browser}&dv=#{$device}&bv=#{$browser_version}&pvid=#{$pvid}&ssid=#{$ssid}&uid=#{$uid}&ssd=#{$session_depth}&os=#{$os}&lang=#{$language}&rf=#{$referral_source}&ru=#{$returning_user}&ssrf=#{$session_referral}&aud=#{$audience}"
	$geo_loaded = "http://54.152.2.180:8080/CollectorxQA/qa.contentunlock.s3.amazonaws.com/data/?evt=gl&tpc=adg&dn=#{$domain}&url=#{$url}&br=#{$browser}&dv=#{$device}&bv=#{$browser_version}&pvid=#{$pvid}&ssid=#{$ssid}&uid=#{$uid}&ssd=#{$session_depth}&os=#{$os}&lang=#{$language}&rf=#{$referral_source}&ru=#{$returning_user}&ssrf=#{$session_referral}&lat=#{$latitude}&lg=#{$longitude}&cty=#{$country}&reg=#{$region}&cit=#{$city}&ip=#{$ip_address}"
	$session_initiated = "http://54.152.2.180:8080/CollectorxQA/qa.contentunlock.s3.amazonaws.com/data/?evt=si&tpc=adg&dn=#{$domain}&url=#{$url}&br=#{$browser}&dv=#{$device}&bv=#{$browser_version}&pvid=#{$pvid}&ssid=#{$ssid}&ssd=#{$session_depth}&os=#{$os}&lang=#{$language}&rf=#{$referral_source}&ssrf=#{$session_referral}"
	$user_created = "http://54.152.2.180:8080/CollectorxQA/qa.contentunlock.s3.amazonaws.com/data/?evt=ucr&tpc=adg&dn=#{$domain}&url=#{$url}&br=#{$browser}&dv=#{$device}&bv=#{$browser_version}&pvid=#{$pvid}&ssid=#{$ssid}&uid=#{$uid}&ssd=#{$session_depth}&os=#{$os}&lang=#{$language}&rf=#{$referral_source}&ssrf=#{$session_referral}"
	 
	#ADG Events
	$tag_loaded = ""
	$free_view_allowed = ""
	$ad_request = ""
	$invalid_configuration = ""
	$ad_response_received = "" 
	$no_ad_response = ""
	$ad_loaded = "http://54.152.2.180:8080/CollectorxQA/qa.contentunlock.s3.amazonaws.com/data/?evt=al&tpc=adg&dn=#{$domain}&sid=#{$site_id}&url=#{$url}&iid=#{$intercept_id}&ap=#{$autoplay}&moa=#{$mute_on_autoplay}&pe=#{$passback_enabled}&br=#{$browser}&bv=#{$browser_version}&skt=#{$skip_time}&pvid=#{$pvid}&rf=#{$referral_source}&ssrf=#{$session_referral}&ssid=#{$ssid}&uid=#{$uid}&aid=#{$ad_id}"
	$ad_load_failure = ""
	$ui_loaded = ""
	$ui_load_failure = ""
	$passback_sent = ""
	$hover_on_player = "" 
	$click_to_play = "" 
	$skip = ""
	$abandon = ""
	$ad_click_through = ""
	$ad_start = "http://54.152.2.180:8080/CollectorxQA/qa.contentunlock.s3.amazonaws.com/data/?evt=as&tpc=adg&dn=#{$domain}&sid=#{$site_id}&url=#{$url}&iid=#{$intercept_id}&ap=#{$autoplay}&moa=#{$mute_on_autoplay}&pe=#{$passback_enabled}&br=#{$browser}&bv=#{$browser_version}&skt=#{$skip_time}&pvid=#{$pvid}&rf=#{$referral_source}&ssrf=#{$session_referral}&ssid=#{$ssid}&uid=#{$uid}&aid=#{$ad_id}"
	$ad_first_quartile = ""
	$ad_second_quartile = ""
	$ad_second_quartile = ""
	$ad_third_quartile = ""
	$unit_displayed = ""
	$ad_completed = ""
	$unit_closed = ""
	$ad_video_start = "http://54.152.2.180:8080/CollectorxQA/qa.contentunlock.s3.amazonaws.com/data/?evt=avs&tpc=adg&dn=#{$domain}&sid=#{$site_id}&url=#{$url}&iid=#{$intercept_id}&ap=#{$autoplay}&moa=#{$mute_on_autoplay}&pe=#{$passback_enabled}&br=#{$browser}&bv=#{$browser_version}&skt=#{$skip_time}&pvid=#{$pvid}&rf=#{$referral_source}&ssrf=#{$session_referral}&ssid=#{$ssid}&uid=#{$uid}&aid=#{$ad_id}"
	$mute_clicked = ""
	$eligible_ad_playback = "http://54.152.2.180:8080/CollectorxQA/qa.contentunlock.s3.amazonaws.com/data/?evt=eap&tpc=adg&dn=#{$domain}&sid=#{$site_id}&url=#{$url}&iid=#{$intercept_id}&ap=#{$autoplay}&moa=#{$mute_on_autoplay}&pe=#{$passback_enabled}&br=#{$browser}&bv=#{$browser_version}&skt=#{$skip_time}&pvid=#{$pvid}&rf=#{$referral_source}&ssrf=#{$session_referral}&ssid=#{$ssid}&uid=#{$uid}&aid=#{$ad_id}"
	$eligible_ad_start = "http://54.152.2.180:8080/CollectorxQA/qa.contentunlock.s3.amazonaws.com/data/?evt=eas&tpc=adg&dn=#{$domain}&sid=#{$site_id}&url=#{$url}&iid=#{$intercept_id}&ap=#{$autoplay}&moa=#{$mute_on_autoplay}&pe=#{$passback_enabled}&br=#{$browser}&bv=#{$browser_version}&skt=#{$skip_time}&pvid=#{$pvid}&rf=#{$referral_source}&ssrf=#{$session_referral}&ssid=#{$ssid}&uid=#{$uid}&aid=#{$ad_id}" 
end 
