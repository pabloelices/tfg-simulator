with Ada.Real_Time; use Ada.Real_Time;

with Maneuvering.Driver;
with Utils;

package Driver is

   type Bundle is new Maneuvering.Driver.Bundle with null record;

   procedure On_Start (Self : in out Bundle);
	
   procedure On_Loop (Self : in out Bundle; Elapsed_Time : Time_Span);
   
   procedure On_End (Self : in out Bundle);

end Driver;
