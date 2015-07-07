require "watir-webdriver"
require "rubygems"
require "rspec"

Watir.default_timeout = 60

describe "An invalid CSS_Path" do 
	let(:x) { @browser ||= Watir::Browser.new :chrome }
	before {x.goto "http://qa.contentunlock.s3.amazonaws.com/QA_SprintTesting/ADG_Watir_Tests/Filter_Referrers/demo.html"; event_data = []}
	after {x.quit}

	it "should result in a Free View Allowed" do
		sleep 3 
		event_data = x.execute_script("return GMData.EventHandler.getEventStack()")
		fva_reason = x.execute_script("return ADG.FilterHandler.getReason()")
		expect(event_data).to eq ["START", "TAG_LOADED", "FREE_VIEW_ALLOWED"]
	end
end