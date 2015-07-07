require 'watir-webdriver'
require 'rubygems'
require "rspec"
require "watir-scroll"

Watir.default_timeout = 60


describe "A Regression Test Suite for Chrome" do
	let(:x) { @browser ||= Watir::Browser.new :chrome }
	before {x.goto "http://qa.contentunlock.s3.amazonaws.com/QA_SprintTesting/ADG_Watir_Tests/demo/demo.html"; event_data = []}
	after {x.quit}

	#Start Modal Tests

	it "should run an autoplay an ad inside a Modal unit and run to completion" do
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
				event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
					until event.include? 'ELIGIBLE_AD_PLAYBACK' do
						event = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
					end
					unless event.include? 'ELIGIBLE_AD_START'
							puts "EAP fired with EAS"
					end
				time = x.execute_script("return CUPlayerInstance.time()")
				duration = x.execute_script("return CUPlayerInstance.duration()")
				locked.wait_while_present
				event_data = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
				expect(event_data).to eq ["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED","AD_START", "UNIT_DISPLAYED", "AD_VIDEO_START", "ELIGIBLE_AD_START", "AD_FIRST_QUARTILE", "ELIGIBLE_AD_PLAYBACK", "AD_SECOND_QUARTILE", "AD_THIRD_QUARTILE", "AD_COMPLETE", "UNIT_CLOSED"]
			expect(duration).to be > 0
			expect(time).to be > 14
	end
		it "should run an autoplay ad inside a Modal unit and skip the ad after 3 seconds" do
			Watir::Wait.until {x.div(:class => "container").present?}
				intercept = x.input(:id => "modal").click
				skip = x.input(:id => "delay_skip").click
				skip_time = x.text_field(:id => "secs").set "3"
				autoplay = x.input(:id => "autoplay").click
				submit = x.input(:id => "submit").click
				url = x.link(:text => "Click here for test page").click

		x.window(:title => "Things You Can Do to be More Stylish - The 11 Habits Of Stylish Men - Esquire").use do
			Watir::Wait.until {x.div(:class => "adgOverlay").present?}
			Watir::Wait.until {x.div(:class => "adgContinue").text === "Continue »"}
				x.div(:class => "adgContinue").click
				event_data = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
				expect(event_data).to eq ["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED","AD_START", "UNIT_DISPLAYED", "AD_VIDEO_START", "SKIP", "UNIT_CLOSED"]
		end
	end

	# it "should run a CTP ad inside a Modal unit and run to completion" do
	# 	Watir::Wait.until {x.div(:class => "container").present?}
	# 		intercept = x.input(:id => "modal").click
	# 		skip = x.input(:id => "immediate_skip").click
	# 		autoplay = x.input(:id => "ctp").click
	# 		submit = x.input(:id => "submit").click
	# 		url = x.link(:text => "Click here for test page").click

	# 	x.window(:title => "Things You Can Do to be More Stylish - The 11 Habits Of Stylish Men - Esquire").use do
	# 	Watir::Wait.until {x.div(:class => "adgOverlay").present?}
	# 	Watir::Wait.until {x.div(:id => "adgPlayerWrapper").present?}
	# 	sleep 1
	# 		x.div(:id => "adgPlayerWrapper").hover
	# 		x.div(:id => "adgPlayerWrapper").click
	# 		x.div(:class => "adgOverlay").wait_while_present

	# 		event_data = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
	# 		expect(event_data).to eq ["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED", "AD_START", "UNIT_DISPLAYED", "HOVER_ON_PLAYER", "CLICK_TO_PLAY", "AD_VIDEO_START", "AD_FIRST_QUARTILE", "AD_SECOND_QUARTILE", "AD_THIRD_QUARTILE", "AD_COMPLETE", "UNIT_CLOSED"]
	# 	end
	# end

	# it "should run a CTP ad inside a Modal unit and skip the ad after 3 seconds" do
	# 	Watir::Wait.until {x.div(:class => "container").present?}
	# 		intercept = x.input(:id => "modal").click
	# 		skip = x.input(:id => "delay_skip").click
	# 		skip_time = x.text_field(:id => "secs").set "3"
	# 		autoplay = x.input(:id => "ctp").click
	# 		submit = x.input(:id => "submit").click
	# 		url = x.link(:text => "Click here for test page").click
	# 	x.window(:title => "Things You Can Do to be More Stylish - The 11 Habits Of Stylish Men - Esquire").use do
	# 	Watir::Wait.until {x.div(:class => "adgOverlay").present?}
	# 	Watir::Wait.until {x.div(:id => "adgPlayerWrapper").present?}
	# 	sleep 1
	# 		x.div(:id => "adgPlayerWrapper").hover
	# 		x.div(:id => "adgPlayerWrapper").click

	# 	Watir::Wait.until {x.div(:class => "adgContinue").text === "Continue »"}
	# 		x.div(:class => "adgContinue").click
	# 		event_data = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
	# 		expect(event_data).to eq ["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED","AD_START", "UNIT_DISPLAYED", "HOVER_ON_PLAYER", "CLICK_TO_PLAY", "AD_VIDEO_START", "SKIP", "UNIT_CLOSED"]
	# 	end
	# end

	it "should load a CTP ad inside a Modal unit and skip the ad before playback begins" do
		Watir::Wait.until {x.div(:class => "container").present?}
			intercept = x.input(:id => "modal").click
			skip = x.input(:id => "immediate_skip").click
			autoplay = x.input(:id => "ctp").click
			skip_countdown = x.input(:id => "before_playback").click
			submit = x.input(:id => "submit").click
			x.link(:text => "Click here for test page").click
	
		x.window(:title => "Things You Can Do to be More Stylish - The 11 Habits Of Stylish Men - Esquire").use do
		Watir::Wait.until {x.div(:class => "adgOverlay").present?}
		Watir::Wait.until {x.div(:class => "adgContinue").text === "Continue »"}
		sleep 1
			x.div(:class => "adgContinue").hover
			x.div(:class => "adgContinue").click

			event_data = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
			expect(event_data).to eq ["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED", "AD_START", "UNIT_DISPLAYED", "SKIP", "UNIT_CLOSED"]
		end
	end

	#End Modal Tests
	#Start Locking Tests

	it "should run an autoplay ad inside a Locking unit and run to completion" do
		Watir::Wait.until {x.div(:class => "container").present?}
			intercept = x.input(:id => "locking").click
			skip = x.input(:id => "immediate_skip").click
			autoplay = x.input(:id => "autoplay").click
			submit = x.input(:id => "submit").click
			url = x.link(:text => "Click here for test page").click

		x.window(:title => "Things You Can Do to be More Stylish - The 11 Habits Of Stylish Men - Esquire").use do
		Watir::Wait.until {x.div(:class => "adgOverlay").exists?}
			x.scroll.to [0, 1200]
		Watir::Wait.until {x.div(:id => "adgPlayerWrapper").present?}
			x.div(:class => "adgOverlay").wait_while_present
			event_data = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
			expect(event_data).to eq ["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED", "AD_START", "UNIT_DISPLAYED", "AD_VIDEO_START", "AD_FIRST_QUARTILE", "AD_SECOND_QUARTILE", "AD_THIRD_QUARTILE", "AD_COMPLETE", "UNIT_CLOSED"]			
		end	
	end	

	it "should run an autoplay ad inside a Locking unit and skip the ad after 3 seconds" do
		Watir::Wait.until {x.div(:class => "container").exists?}
			intercept = x.input(:id => "locking").click
			skip = x.input(:id => "delay_skip").click
			skip_time = x.text_field(:id => "secs").set "3"
			autoplay = x.input(:id => "autoplay").click
			submit = x.input(:id => "submit").click
			url = x.link(:text => "Click here for test page").click

		x.window(:title => "Things You Can Do to be More Stylish - The 11 Habits Of Stylish Men - Esquire").use do
		Watir::Wait.until {x.div(:class => "adgOverlay").exists?}
			x.scroll.to [0, 1200]
		Watir::Wait.until {x.div(:class => "adgContinue").text === "Continue »"}
			x.div(:class => "adgContinue").click
		event_data = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
		expect(event_data).to eq ["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED", "AD_START", "UNIT_DISPLAYED", "AD_VIDEO_START", "SKIP", "UNIT_CLOSED"]
		end
	end

	# it "should lock the page, load a CTP unit, and run to completion" do
	# 	Watir::Wait.until {x.div(:class => "container").exists?}
	# 		intercept = x.input(:id => "locking").click
	# 		skip = x.input(:id => "immediate_skip").click
	# 		autoplay = x.input(:id => "ctp").click
	# 		submit = x.input(:id => "submit").click
	# 		url = x.link(:text => "Click here for test page").click
	# 	x.window(:title => "Things You Can Do to be More Stylish - The 11 Habits Of Stylish Men - Esquire").use do
	# 	Watir::Wait.until {x.div(:class => "adgOverlay").exists?}
	# 		x.scroll.to [0, 1200]
	# 	Watir::Wait.until {x.div(:id => "adgPlayerWrapper").present?}
	# 	sleep 1
	# 		x.div(:id => "adgPlayerWrapper").hover
	# 		x.div(:id => "adgPlayerWrapper").click
	# 		x.div(:class => "adgOverlay").wait_while_present
	# 	event_data = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
	# 	expect(event_data).to eq ["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED","AD_START", "UNIT_DISPLAYED","HOVER_ON_PLAYER", "CLICK_TO_PLAY", "AD_VIDEO_START", "AD_FIRST_QUARTILE", "AD_SECOND_QUARTILE", "AD_THIRD_QUARTILE", "AD_COMPLETE", "UNIT_CLOSED"]
	# 	end
	# end

	# it "should lock the page, load a CTP unit, and skip the ad after 3 seconds" do
	# 	Watir::Wait.until {x.div(:class => "container").exists?}
	# 		intercept = x.input(:id => "locking").click
	# 		skip = x.input(:id => "delay_skip").click
	# 		skip_time = x.text_field(:id => "secs").set "3"
	# 		autoplay = x.input(:id => "ctp").click
	# 		submit = x.input(:id => "submit").click
	# 		url = x.link(:text => "Click here for test page").click

	# 	x.window(:title => "Things You Can Do to be More Stylish - The 11 Habits Of Stylish Men - Esquire").use do
	# 	Watir::Wait.until {x.div(:class => "adgOverlay").exists?}
	# 		x.scroll.to [0, 1200]
	# 	Watir::Wait.until {x.div(:id => "adgPlayerWrapper").present?}
	# 	sleep 1
	# 		x.div(:id => "adgPlayerWrapper").hover
	# 		x.div(:id => "adgPlayerWrapper").click
	# 	Watir::Wait.until {x.div(:class => "adgContinue").text === "Continue »"}
	# 		x.div(:class => "adgContinue").hover
	# 		x.div(:class => "adgContinue").click
	# 	event_data = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
	# 	expect(event_data).to eq ["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED", "AD_START", "UNIT_DISPLAYED","HOVER_ON_PLAYER", "CLICK_TO_PLAY","AD_VIDEO_START", "SKIP", "UNIT_CLOSED"]
	# 	end
	# end

	it "should load a CTP ad into a Locking unit and skip the ad before ad playback begins" do
		Watir::Wait.until {x.div(:class => "container").exists?}	
			intercept = x.input(:id => "locking").click
			skip = x.input(:id => "immediate_skip").click
			autoplay = x.input(:id => "ctp").click
			skip_countdown = x.input(:id => "before_playback").click
			submit = x.input(:id => "submit").click
			url = x.link(:text => "Click here for test page").click

		x.window(:title => "Things You Can Do to be More Stylish - The 11 Habits Of Stylish Men - Esquire").use do
		Watir::Wait.until {x.div(:class => "adgOverlay").exists?}
			x.scroll.to [0, 1200]
			sleep 3
		Watir::Wait.until {x.div(:class => "adgContinue").text === "Continue »"}
			x.div(:class => "adgContinue").hover
			x.div(:class => "adgContinue").click
		event_data = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
		expect(event_data).to eq ["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED","AD_START", "UNIT_DISPLAYED", "SKIP", "UNIT_CLOSED"]
		end
	end

	# #End Locking Tests
	# #Start Nonlocking Tests

	it "should load an autoplay ad inside a Nonlocking unit and run to completion" do
		Watir::Wait.until {x.div(:class => "container").exists?}	
			intercept = x.input(:id => "nonlocking").click
			submit = x.input(:id => "submit").click
			url = x.link(:text => "Click here for test page").click

		x.window(:title => "Things You Can Do to be More Stylish - The 11 Habits Of Stylish Men - Esquire").use do
		Watir::Wait.until {x.div(:id => "adgSlate").present?}
			x.scroll.to [0, 1200]
			x.div(:class => "adgSlate").wait_while_present
			event_data = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
			expect(event_data).to eq ["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED","AD_START", "UNIT_DISPLAYED", "AD_VIDEO_START", "AD_FIRST_QUARTILE", "AD_SECOND_QUARTILE", "AD_THIRD_QUARTILE", "AD_COMPLETE", "UNIT_CLOSED"]
		end
	end

	it "should load an autoplay ad inside a Nonlocking unit, start playback, scroll out of view to initiate a pause, and then scroll back to resume playback to completion" do
		Watir::Wait.until {x.div(:class => "container").exists?}	
					intercept = x.input(:id => "nonlocking").click
					submit = x.input(:id => "submit").click
					url = x.link(:text => "Click here for test page").click

		x.window(:title => "Things You Can Do to be More Stylish - The 11 Habits Of Stylish Men - Esquire").use do			
		Watir::Wait.until {x.div(:class => "adgSlate").present?}
			x.scroll.to [0, 1200]
				sleep 4
			x.scroll.to :top
				sleep 1
			x.scroll.to [0, 1200]
			x.div(:class => "adgSlate").wait_while_present
			event_data = x.execute_script("return GMData.ADGEventHandler.getEventStack()")
			expect(event_data).to eq ["START", "TAG_LOADED", "UI_LOADED", "AD_REQUEST", "AD_RESPONSE_RECEIVED", "AD_LOADED","AD_START", "UNIT_DISPLAYED", "AD_VIDEO_START", "AD_FIRST_QUARTILE", "AD_SECOND_QUARTILE", "AD_THIRD_QUARTILE", "AD_COMPLETE", "UNIT_CLOSED"]
		end
	end

	#End Nonlocking Tests
	#Start Exclusion Tets



end