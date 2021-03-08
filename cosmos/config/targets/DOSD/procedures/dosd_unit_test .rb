
require 'osk_system'
require 'app_func_test'
require 'osk_global'
require 'fsw_const'
require 'fsw_config_param'

class DosdUnitTest < Cosmos::Test

   
   def initialize
      Osk::System.check_n_start_cfs
      FswApp.validate_cmd(false) # This module provides methods that verify valid/invalid command counters for expected errors
      @app = Osk::flight.app[target_str]
   end

    #NOOP and RESET commands are tested in app_func_test.rb
   def test_detect_cmd
      puts "IN DETECTION TEST"
      test_passed = AppFuncTest.send_cmd(@app,"DETECT") do |app_name, event_type, event_msg|
      wait(2)
      system("gnome-terminal --title='Injecting Flood Attack...' -e 'sudo netwox 76 -i 10.0.2.15 -p 23 -s raw' 2> /dev/null");
      Osk::flight.send_cmd("CFE_ES","START_APP", "APP_NAME" "DOSD", "APP_ENTRY_POINT" "DOSD_AppMain", 
"APP_FILENAME" "/cf/dosd.so")
      end #end do
      raise "Failed detect command verification" unless test_passed
   end #end test_detect_cmd

    





   def helper_method
   end



end

