package body Actuators.Electronic_Speed_Controllers is

   -----------
   -- Agent --
   -----------
   
   protected body Agent is
      
      ----------------------
      -- Get_Pulse_Widths --
      ----------------------
      
      function Get_Pulse_Widths return Real_Vector is        
      begin
         return Agent.Pulse_Widths;
      end Get_Pulse_Widths;
      
      ----------------------
      -- Put_Pulse_Widths --
      ----------------------
      
      procedure Put_Pulse_Widths (Pulse_Widths : Real_Vector) is
      begin
         Agent.Pulse_Widths := Utils.Clamp (Pulse_Widths, Actuators.ESC_Min_Pulse_Width, Actuators.ESC_Max_Pulse_Width);
      end Put_Pulse_Widths;
      
   end Agent;	

end Actuators.Electronic_Speed_Controllers;
