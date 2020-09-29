
package Logging.Logger is
   
   type Bundle (File_Handler : access File_Type;
                File_Path : access String;
                References : Flight_Controller.Any_References_Reader;
                ESCs : Actuators.Any_ESCs_Reader;
                Motors : Actuators.Any_Motors_Reader;
                Motion : Multicopter.Any_Motion_Reader;
                Absolute_Orientation_Sensor : Sensors.Any_Absolute_Orientation_Sensor_Reader)
   
   is new Cyclics.Bundle with null record;
	
   procedure On_Start (Self : in out Bundle);
	
   procedure On_Loop (Self : in out Bundle; Elapsed_Time : Time_Span);
   
   procedure On_End (Self : in out Bundle);

end Logging.Logger;
