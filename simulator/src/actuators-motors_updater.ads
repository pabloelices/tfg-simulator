package Actuators.Motors_Updater is

   type Bundle (ESCs : Actuators.Any_ESCs_Reader;
                Motors : Any_Motors_Operations) is new Cyclics.Bundle with null record;
	
   procedure On_Start (Self : in out Bundle);
	
   procedure On_Loop (Self : in out Bundle; Elapsed_Time : Time_Span);
   
   procedure On_End (Self : in out Bundle);

end Actuators.Motors_Updater;
