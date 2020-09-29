package Multicopter.Motion_Updater is
   
   type Bundle (Motors : Actuators.Any_Motors_Reader; Motion : Any_Motion_Operations) is new Cyclics.Bundle with null record;
	
   procedure On_Start (Self : in out Bundle);
	
   procedure On_Loop (Self : in out Bundle; Elapsed_Time : Time_Span);
   
   procedure On_End (Self : in out Bundle);

end Multicopter.Motion_Updater;
