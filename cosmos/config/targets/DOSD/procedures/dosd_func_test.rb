#NOOP and RESET commands are tested in app_func_test.rb

require 'osk_system'
require 'app_func_test'

class DosdFuncTest < Cosmos::Test

   include AppFuncTest

   
   def initialize
      super()
      @app = app_func_test_init("DOSD")
   end

   def setup
      status_bar("#{Cosmos::Test.current_test_suite}:#{Cosmos::Test.current_test}:#{Cosmos::Test.current_test_case} - setup")
      puts "Running #{Cosmos::Test.current_test_suite}:#{Cosmos::Test.current_test}:#{Cosmos::Test.current_test_case}"
      wait(2)
   end

   def teardown
      status_bar("teardown")
      puts "Running 		   #{Cosmos::Test.current_test_suite}:#{Cosmos::Test.current_test}:#{Cosmos::Test.current_test_case}"
      wait(2)
   end


   #DOSD needs to be tested supervised. tftp disconnects after detection & cannot get valid count
   def test_detect_cmd
      puts "IN DETECTION TEST"
      @app = Osk::flight.app["DOSD"]
      target_hk_str = "#{app.target} #{app.hk_pkt}"
      cmd_valid_cnt = tlm("#{target_hk_str} #{Osk::TLM_STR_CMD_VLD}")
      cmd_error_cnt = tlm("#{target_hk_str} #{Osk::TLM_STR_CMD_ERR}")

      Osk::flight.send_cmd("DOSD","DETECT")
      wait(2)
      system("gnome-terminal --title='Injecting Flood Attack...' -e 'sudo netwox 76 -i 10.0.2.15 -p 23 -s raw'");
      wait(3)

   # Osk::flight.send_cmd("CFE_ES","START_APP with APP_NAME 'DOSD', APP_ENTRY_POINT 'DOSD_AppMain', APP_FILENAME '/cf/dosd.so'")


      #as long as command is not invalid
      expected_result = 
      (cmd_error_cnt == tlm("#{target_hk_str} #{Osk::TLM_STR_CMD_ERR}")) 
	#and cmd_valid_cnt == tlm("#{target_hk_str} #{Osk::TLM_STR_CMD_VLD}")+1  #cannot increment when tftp stop
	
      puts expected_result
      raise "Failed detect command verification" unless expected_result
   end #end test_detect_cmd


   def helper_method
   end



end

