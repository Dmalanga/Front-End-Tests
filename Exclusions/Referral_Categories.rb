require "rspec"
require "watir-webdriver"
require "rubygems"

Watir.default_timeout = 60

describe "An Excluded Referral Category test" do
	let(:x) { @browser ||= Watir::Browser.new :chrome }
	before {x.goto "http://qa.contentunlock.s3.amazonaws.com/QA_SprintTesting/ADG_Watir_Tests/Referral_Categories/demo.html"; event_data = []}
	after {x.quit}

	it "should not invoke a unit and fire a Free View Allowed event" do
		sleep 3
		event_data = x.execute_script("return GMData.EventHandler.getEventStack()")
		fva_reason = x.execute_script("return ADG.FilterHandler.getReason()")
		expect(event_data).to eq ["START", "TAG_LOADED", "FREE_VIEW_ALLOWED"]
		expect(fva_reason).to eq "referralCategory"
	end
end