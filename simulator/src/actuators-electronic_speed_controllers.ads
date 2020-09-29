package Actuators.Electronic_Speed_Controllers is

   protected type Agent (Ceiling: Priority) with Priority => Ceiling is new ESCs_Operations with
			
      overriding function Get_Pulse_Widths return Real_Vector;
      
      overriding procedure Put_Pulse_Widths (Pulse_Widths : Real_Vector);
      
   private
      
      Pulse_Widths : Real_Vector (1 .. Actuators.Number_Of_Actuators) := (others => Actuators.ESC_Min_Pulse_Width);
		      		
   end Agent;

end Actuators.Electronic_Speed_Controllers;
