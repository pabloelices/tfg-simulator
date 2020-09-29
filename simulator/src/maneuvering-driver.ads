package Maneuvering.Driver is

   type Bundle (References : Flight_Controller.Any_References_Writer) is abstract new Cyclics.Bundle with null record;
	
   procedure On_Start (Self : in out Bundle) is abstract;
	
   procedure On_Loop (Self : in out Bundle; Elapsed_Time : Time_Span) is abstract;
   
   procedure On_End (Self : in out Bundle) is abstract;

end Maneuvering.Driver;
