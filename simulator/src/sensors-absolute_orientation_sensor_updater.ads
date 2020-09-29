package Sensors.Absolute_Orientation_Sensor_Updater is
   
   type Bundle (Motion : Multicopter.Any_Motion_Reader;
                Absolute_Orientation_Sensor : Any_Absolute_Orientation_Sensor_Operations) is new Cyclics.Bundle with null record;
	
   procedure On_Start (Self : in out Bundle);
	
   procedure On_Loop (Self : in out Bundle; Elapsed_Time : Time_Span);
   
   procedure On_End (Self : in out Bundle);

end Sensors.Absolute_Orientation_Sensor_Updater;
