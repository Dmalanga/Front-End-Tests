require 'watir-webdriver'
require 'rubygems'
require "rspec"
require "watir-scroll"
require "selenium-webdriver"

Watir.default_timeout = 60


describe "A Regression Test Suite for Firefox" do
	let(:x) { @browser ||= Watir::Browser.new :firefox }
	before {x.goto "http://qa.contentunlock.s3.amazonaws.com/QA_SprintTesting/ADG_Watir_Tests/demo/demo.html"; event_data = []}
	after {x.quit}

	#Start Modal Tests

	it "1. Should run an autoplay an ad inside a Modal unit and run to completion" do
		Watir::Wait.until {x.div(:class => "container").present?}
			intercept = x.input(:id => "modal").click
			skip = x.input(:id => "delay_skip").click
			skip_time = x.text_field(:id => "secs").set "15"
			autoplay = x.input(:id => "autoplay").click
			submit = x.input(:id => "submit").click
			url = x.link(:text => "Click here for test page").click
			sleep 5
				locked = x.div(:class => "adgWrapper")
					sleep 3
				duration = x.execute_script("return CUPlayerInstance.duration()")
				event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
				Timeout::timeout(15){
					until duration > 0 do
						duration = x.execute_script("return CUPlayerInstance.duration()")
					end
				}
				time = x.execute_script("return CUPlayerInstance.time()")
				if duration > 14
					Timeout::timeout(15){
						until time > 14 do
							time = x.execute_script("return CUPlayerInstance.time()")
							event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
						end
					}
					expect(event).to include("ELIGIBLE_AD_START", "ELIGIBLE_AD_PLAYBACK")
				else
					event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
					expect(event).not_to include("ELIGIBLE_AD_START")
				end
				locked.wait_while_present
				event_data = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
				expect(event_data).to eq ["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED","UNIT_DISPLAYED", "AD_START", "AD_VIDEO_START", "ELIGIBLE_AD_START", "AD_FIRST_QUARTILE", "ELIGIBLE_AD_PLAYBACK", "AD_SECOND_QUARTILE",  "AD_THIRD_QUARTILE", "AD_COMPLETE", "UNIT_CLOSED"]
	end

	it "2. Should run an autoplay ad inside a Modal unit and skip the ad after 3 seconds" do
		Watir::Wait.until {x.div(:class => "container").present?}
			intercept = x.input(:id => "modal").click
			skip = x.input(:id => "delay_skip").click
			skip_time = x.text_field(:id => "secs").set "3"
			autoplay = x.input(:id => "autoplay").click
			submit = x.input(:id => "submit").click
			url = x.link(:text => "Click here for test page").click
			sleep 5
				locked = x.div(:class => "adgWrapper")
		Watir::Wait.until {x.div(:class => "adgContinue").text === "Continue »"}
				duration = x.execute_script("return CUPlayerInstance.duration()")
				x.div(:class => "adgContinue").click
				event_data = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
				expect(event_data).to eq ["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED","UNIT_DISPLAYED", "AD_START", "AD_VIDEO_START", "HOVER_ON_PLAYER", "SKIP", "UNIT_CLOSED"]
				expect(duration).to be > 0
	
	end

	# it "3. Should run a CTP ad inside a Modal unit and run to completion" do
	# 	Watir::Wait.until {x.div(:class => "container").present?}
	# 		intercept = x.input(:id => "modal").click
	# 		skip = x.input(:id => "delay_skip").click
	# 		skip_time = x.text_field(:id => "secs").set "15"
	# 		autoplay = x.input(:id => "ctp").click
	# 		submit = x.input(:id => "submit").click
	# 		url = x.link(:text => "Click here for test page").click
	# 		sleep 5
	# 			locked = x.div(:class => "adgWrapper")
	# 	Watir::Wait.until {x.div(:id => "adgPlayerWrapper").present?}
	# 			x.div(:id => "adgPlayerWrapper").hover
	# 			x.div(:id => "adgPlayerWrapper").click
	# 			duration = x.execute_script("return CUPlayerInstance.duration()")
	# 			event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
	# 			Timeout::timeout(15){
	# 				until duration > 0 do
	# 					duration = x.execute_script("return CUPlayerInstance.duration()")
	# 				end
	# 			}
	# 			time = x.execute_script("return CUPlayerInstance.time()")
	# 			if duration > 14
	# 				Timeout::timeout(15){
	# 					until time > 14 do
	# 						time = x.execute_script("return CUPlayerInstance.time()")
	# 						event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
	# 					end
	# 				}
	# 				expect(event).to include("ELIGIBLE_AD_START", "ELIGIBLE_AD_PLAYBACK")
	# 			else
	# 				event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
	# 				expect(event).not_to include("ELIGIBLE_AD_START")
	# 			end
	# 			x.div(:class => "adgWrapper").wait_while_present
	# 		event_data = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
	# 		expect(event_data).to eq ["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED","UNIT_DISPLAYED", "AD_START", "HOVER_ON_PLAYER", "CLICK_TO_PLAY", "AD_VIDEO_START", "ELIGIBLE_AD_START", "AD_FIRST_QUARTILE", "ELIGIBLE_AD_PLAYBACK", "AD_SECOND_QUARTILE",  "AD_THIRD_QUARTILE", "AD_COMPLETE", "UNIT_CLOSED"]
	# end

	# it "4. Should run a CTP ad inside a Modal unit and skip the ad after 2 seconds" do
	# 	Watir::Wait.until {x.div(:class => "container").present?}
	# 		intercept = x.input(:id => "modal").click
	# 		skip = x.input(:id => "delay_skip").click
	# 		skip_time = x.text_field(:id => "secs").set "2"
	# 		autoplay = x.input(:id => "ctp").click
	# 		submit = x.input(:id => "submit").click
	# 		url = x.link(:text => "Click here for test page").click
	# 	Watir::Wait.until {x.div(:class => "adgWrapper").present?}
	# 	Watir::Wait.until {x.div(:id => "adgPlayerWrapper").present?}
	# 		x.div(:id => "adgPlayerWrapper").hover
	# 		x.div(:id => "adgPlayerWrapper").click
	# 		sleep 1 
	# 		duration = x.execute_script("return CUPlayerInstance.duration()")
	# 	Watir::Wait.until {x.div(:class => "adgContinue").text === "Continue »"}
	# 		x.div(:class => "adgContinue").click
	# 		event_data = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
	# 		expect(event_data).to eq ["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED","UNIT_DISPLAYED","AD_START", "HOVER_ON_PLAYER", "CLICK_TO_PLAY", "AD_VIDEO_START", "SKIP", "UNIT_CLOSED"]
	# 		expect(duration).to be > 0
	# end

	# it "5. Should load a CTP ad inside a Modal unit and skip the ad before playback begins" do
	# 	Watir::Wait.until {x.div(:class => "container").present?}
	# 		intercept = x.input(:id => "modal").click
	# 		skip = x.input(:id => "immediate_skip").click
	# 		autoplay = x.input(:id => "ctp").click
	# 		skip_countdown = x.input(:id => "before_playback").click
	# 		submit = x.input(:id => "submit").click
	# 		x.link(:text => "Click here for test page").click
	
	# 	Watir::Wait.until {x.div(:class => "adgWrapper").present?}
	#   sleep 2
	# 	Watir::Wait.until {x.div(:class => "adgContinue").text === "Continue »"}
	# 		x.div(:class => "adgContinue").hover
	# 		x.div(:class => "adgContinue").click

	# 		event_data = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
	# 		expect(event_data).to eq ["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED", "UNIT_DISPLAYED", "AD_START", "HOVER_ON_PLAYER", "SKIP", "UNIT_CLOSED"]
	# end

	# # #End Modal Tests
	# # #Start Locking Tests

	it "6. Should run an autoplay ad inside a Locking unit and run to completion" do
		Watir::Wait.until {x.div(:class => "container").present?}
			intercept = x.input(:id => "locking").click
			skip = x.input(:id => "delay_skip").click
			skip_time = x.text_field(:id => "secs").set "15"
			autoplay = x.input(:id => "autoplay").click
			submit = x.input(:id => "submit").click
			url = x.link(:text => "Click here for test page").click
		sleep 3
		Watir::Wait.until {x.div(:class => "adgOverlay").exists?}
			event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
			until event.include? 'AD_START' do
				event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
			end
			x.scroll.to [0, 1200]
		Watir::Wait.until {x.div(:id => "adgPlayerWrapper").present?}
		duration = x.execute_script("return CUPlayerInstance.duration()")
				event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
				Timeout::timeout(15){
					until duration > 0 do
						duration = x.execute_script("return CUPlayerInstance.duration()")
					end
				}
				time = x.execute_script("return CUPlayerInstance.time()")
				if duration > 14
					Timeout::timeout(15){
						until time > 14 do
							time = x.execute_script("return CUPlayerInstance.time()")
							event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
						end
					}
					expect(event).to include("ELIGIBLE_AD_START", "ELIGIBLE_AD_PLAYBACK")
				else
					event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
					expect(event).not_to include("ELIGIBLE_AD_START")
				end
				x.div(:class => "adgWrapper").wait_while_present
		x.div(:class => "adgOverlay").wait_while_present
		event_data = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
		expect(event_data).to satisfy {["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED", "AD_START", "UNIT_DISPLAYED", "AD_VIDEO_START", "ELIGIBLE_AD_START", "AD_FIRST_QUARTILE", "ELIGIBLE_AD_PLAYBACK", "AD_SECOND_QUARTILE", "AD_THIRD_QUARTILE", "AD_COMPLETE", "UNIT_CLOSED"] || ["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED",  "UNIT_DISPLAYED", "AD_START", "AD_VIDEO_START", "ELIGIBLE_AD_START", "AD_FIRST_QUARTILE", "ELIGIBLE_AD_PLAYBACK", "AD_SECOND_QUARTILE", "AD_THIRD_QUARTILE", "AD_COMPLETE", "UNIT_CLOSED"]}		
	end	

	it "7. Should run an autoplay ad inside a Locking unit and skip the ad after 2 seconds" do
		Watir::Wait.until {x.div(:class => "container").exists?}
			intercept = x.input(:id => "locking").click
			skip = x.input(:id => "delay_skip").click
			skip_time = x.text_field(:id => "secs").set "2"
			autoplay = x.input(:id => "autoplay").click
			submit = x.input(:id => "submit").click
			url = x.link(:text => "Click here for test page").click

		Watir::Wait.until {x.div(:class => "adgOverlay").exists?}
			event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
			until event.include? 'AD_START' do
					event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
			end
			x.scroll.to [0, 1200]
		Watir::Wait.until {x.div(:class => "adgContinue").text === "Continue »"}
			x.div(:class => "adgContinue").click
		event_data = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
		expect(event_data).to satisfy {["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED", "AD_START", "UNIT_DISPLAYED",  "AD_VIDEO_START", "HOVER_ON_PLAYER", "SKIP", "UNIT_CLOSED"] || ["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED", "UNIT_DISPLAYED", "AD_START", "AD_VIDEO_START", "HOVER_ON_PLAYER", "SKIP", "UNIT_CLOSED"]}
	end

	# it "8. Should lock the page, load a CTP unit, and run to completion" do
	# 	Watir::Wait.until {x.div(:class => "container").exists?}
	# 		intercept = x.input(:id => "locking").click
	# 		skip = x.input(:id => "delay_skip").click
	# 		skip_time = x.text_field(:id => "secs").set "15"
	# 		autoplay = x.input(:id => "ctp").click
	# 		submit = x.input(:id => "submit").click
	# 		url = x.link(:text => "Click here for test page").click
	# 	sleep 3
	# 	Watir::Wait.until {x.div(:class => "adgOverlay").exists?}
	# 		event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
	# 		until event.include? 'AD_START' do
	# 			event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
	# 		end
	# 		x.scroll.to [0, 1200]
	# 	Watir::Wait.until {x.div(:id => "adgPlayerWrapper").present?}
	# 		x.div(:id => "adgPlayerWrapper").hover
	# 		x.div(:id => "adgPlayerWrapper").click
	# 		sleep 3
	# 						duration = x.execute_script("return CUPlayerInstance.duration()")
	# 			event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
	# 			Timeout::timeout(15){
	# 				until duration > 0 do
	# 					duration = x.execute_script("return CUPlayerInstance.duration()")
	# 				end
	# 			}
	# 			time = x.execute_script("return CUPlayerInstance.time()")
	# 			if duration > 14
	# 				Timeout::timeout(15){
	# 					until time > 14 do
	# 						time = x.execute_script("return CUPlayerInstance.time()")
	# 						event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
	# 					end
	# 				}
	# 				expect(event).to include("ELIGIBLE_AD_START", "ELIGIBLE_AD_PLAYBACK")
	# 			else
	# 				event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
	# 				expect(event).not_to include("ELIGIBLE_AD_START")
	# 			end
	# 		x.div(:class => "adgOverlay").wait_while_present
	# 	event_data = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
	# 	expect(event_data).to satisfy {["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED","AD_START", "UNIT_DISPLAYED", "HOVER_ON_PLAYER", "CLICK_TO_PLAY", "AD_VIDEO_START", "ELIGIBLE_AD_START", "AD_FIRST_QUARTILE", "ELIGIBLE_AD_PLAYBACK", "AD_SECOND_QUARTILE", "AD_THIRD_QUARTILE", "AD_COMPLETE", "UNIT_CLOSED"] || ["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED", "UNIT_DISPLAYED", "AD_START", "HOVER_ON_PLAYER", "CLICK_TO_PLAY", "AD_VIDEO_START", "ELIGIBLE_AD_START", "AD_FIRST_QUARTILE", "ELIGIBLE_AD_PLAYBACK", "AD_SECOND_QUARTILE", "AD_THIRD_QUARTILE", "AD_COMPLETE", "UNIT_CLOSED"]}
	# end

	# it "9. Should lock the page, load a CTP unit, and skip the ad after 2 seconds" do
	# 	Watir::Wait.until {x.div(:class => "container").exists?}
	# 		intercept = x.input(:id => "locking").click
	# 		skip = x.input(:id => "delay_skip").click
	# 		skip_time = x.text_field(:id => "secs").set "2"
	# 		autoplay = x.input(:id => "ctp").click
	# 		submit = x.input(:id => "submit").click
	# 		url = x.link(:text => "Click here for test page").click

	# 	Watir::Wait.until {x.div(:class => "adgOverlay").exists?}
	# 		event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
	# 		until event.include? 'AD_START' do
	# 			event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
	# 		end
	# 		x.scroll.to [0, 1200]
	# 	Watir::Wait.until {x.div(:id => "adgPlayerWrapper").present?}
	# 		x.div(:id => "adgPlayerWrapper").hover
	# 		x.div(:id => "adgPlayerWrapper").click
	# 		duration = x.execute_script("return CUPlayerInstance.duration()")
	# 	Watir::Wait.until {x.div(:class => "adgContinue").text === "Continue »"}
	# 		x.div(:class => "adgContinue").hover
	# 		x.div(:class => "adgContinue").click
	# 	event_data = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
	# 	expect(event_data).to satisfy {["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED","AD_START", "UNIT_DISPLAYED", "HOVER_ON_PLAYER", "CLICK_TO_PLAY","AD_VIDEO_START", "SKIP", "UNIT_CLOSED"] || ["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED","UNIT_DISPLAYED", "AD_START", "HOVER_ON_PLAYER", "CLICK_TO_PLAY","AD_VIDEO_START", "SKIP", "UNIT_CLOSED"]}
	# 	expect(duration).to be > 0
	# end

	# it "10. hould load a CTP ad into a Locking unit and skip the ad before ad playback begins" do
	# 	Watir::Wait.until {x.div(:class => "container").exists?}	
	# 		intercept = x.input(:id => "locking").click
	# 		skip = x.input(:id => "immediate_skip").click
	# 		autoplay = x.input(:id => "ctp").click
	# 		skip_countdown = x.input(:id => "before_playback").click
	# 		submit = x.input(:id => "submit").click
	# 		url = x.link(:text => "Click here for test page").click

	# 	Watir::Wait.until {x.div(:class => "adgOverlay").exists?}
	# 		event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
	# 			until event.include? 'AD_START' do
	# 				event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
	# 			end
	# 		x.scroll.to [0, 1200]
	# 		sleep 3
	# 	Watir::Wait.until {x.div(:class => "adgContinue").text === "Continue »"}
	# 		x.div(:class => "adgContinue").hover
	# 		x.div(:class => "adgContinue").click
	# 	event_data = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
	# 	expect(event_data).to satisfy {["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED","UNIT_DISPLAYED", "AD_START", "HOVER_ON_PLAYER", "SKIP", "UNIT_CLOSED"] || ["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED","AD_START", "UNIT_DISPLAYED", "HOVER_ON_PLAYER", "SKIP", "UNIT_CLOSED"]}
	# end

	# # # #End Locking Tests
	# # # #Start Nonlocking Tests

	it "11. Should load an autoplay ad inside a Nonlocking unit and run to completion" do
		Watir::Wait.until {x.div(:class => "container").exists?}	
			intercept = x.input(:id => "nonlocking").click
			submit = x.input(:id => "submit").click
			url = x.link(:text => "Click here for test page").click
		sleep 3
		Watir::Wait.until {x.div(:id => "adgSlate").present?}
			event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
				until event.include? 'AD_START' do
					event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
				end
			x.scroll.to [0, 1200]
			duration = x.execute_script("return CUPlayerInstance.duration()")
			event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
				Timeout::timeout(15){
					until duration > 0 do
						duration = x.execute_script("return CUPlayerInstance.duration()")
					end
				}
			time = x.execute_script("return CUPlayerInstance.time()")
				if duration > 14
					Timeout::timeout(15){
						until time > 14 do
							time = x.execute_script("return CUPlayerInstance.time()")
							event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
						end
					}
					expect(event).to include("ELIGIBLE_AD_START", "ELIGIBLE_AD_PLAYBACK")
				else
					event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
					expect(event).not_to include("ELIGIBLE_AD_START")
				end
			x.div(:class => "adgSlate").wait_while_present
			event_data = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
			expect(event_data).to satisfy {["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED", "AD_START", "UNIT_DISPLAYED", "AD_VIDEO_START", "ELIGIBLE_AD_START", "AD_FIRST_QUARTILE", "ELIGIBLE_AD_PLAYBACK", "AD_SECOND_QUARTILE", "AD_THIRD_QUARTILE", "AD_COMPLETE", "UNIT_CLOSED"] || ["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED", "UNIT_DISPLAYED", "AD_START", "AD_VIDEO_START", "ELIGIBLE_AD_START", "AD_FIRST_QUARTILE", "ELIGIBLE_AD_PLAYBACK", "AD_SECOND_QUARTILE", "AD_THIRD_QUARTILE", "AD_COMPLETE", "UNIT_CLOSED"]}
	end

	it "12. Should load an autoplay ad inside a Nonlocking unit, start playback, scroll out of view to initiate a pause, and then scroll back to resume playback to completion" do
		Watir::Wait.until {x.div(:class => "container").exists?}	
					intercept = x.input(:id => "nonlocking").click
					submit = x.input(:id => "submit").click
					url = x.link(:text => "Click here for test page").click
		sleep 3
		Watir::Wait.until {x.div(:class => "adgSlate").present?}
			event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
			until event.include? 'AD_START' do
				event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
			end
			x.scroll.to [0, 1200]
			duration = x.execute_script("return CUPlayerInstance.duration()")
			event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
				Timeout::timeout(15){
					until duration > 0 do
						duration = x.execute_script("return CUPlayerInstance.duration()")
					end
				}
			time = x.execute_script("return CUPlayerInstance.time()")
				sleep 4
			x.scroll.to :top
				sleep 1
			x.scroll.to [0, 1200]
				if duration > 14
					Timeout::timeout(15){
						until time > 14 do
							time = x.execute_script("return CUPlayerInstance.time()")
							event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
						end
					}
					expect(event).to include("ELIGIBLE_AD_START", "ELIGIBLE_AD_PLAYBACK")
				else
					event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
					expect(event).not_to include("ELIGIBLE_AD_START")
				end
			x.div(:class => "adgSlate").wait_while_present
			event_data = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
			expect(event_data).to satisfy {["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED","AD_START", "UNIT_DISPLAYED", "AD_VIDEO_START",  "ELIGIBLE_AD_START", "AD_FIRST_QUARTILE", "ELIGIBLE_AD_PLAYBACK", "AD_SECOND_QUARTILE", "AD_THIRD_QUARTILE", "AD_COMPLETE", "UNIT_CLOSED"] || ["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED", "UNIT_DISPLAYED", "AD_START", "AD_VIDEO_START",  "ELIGIBLE_AD_START", "AD_FIRST_QUARTILE", "ELIGIBLE_AD_PLAYBACK", "AD_SECOND_QUARTILE", "AD_THIRD_QUARTILE", "AD_COMPLETE", "UNIT_CLOSED"]}
	end

	#End Nonlocking Tests
	#Start Exclusion Tets



end