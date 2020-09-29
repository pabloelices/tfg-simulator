package body Mixers is

   ------------
   -- Create --
   ------------
   
   function Create (ESC_Min_Pulse_Width : Float; ESC_Max_Pulse_Width : Float) return Quadcopter_Cross_Mixer is
   begin
      
      -- Validate ESC_Min_Pulse_Width and ESC_Max_Pulse_Width.
      
      if not (ESC_Min_Pulse_Width < ESC_Max_Pulse_Width) then
         
         raise Ilegal_Output_Limits with "ESC_Min_Pulse_Width must be lower than ESC_Max_Pulse_Width";
         
      end if;
      
      -- Create and return.
      
      return (ESC_Min_Pulse_Width => ESC_Min_Pulse_Width, ESC_Max_Pulse_Width => ESC_Max_Pulse_Width);
      
   end Create;

   ---------
   -- Mix --
   ---------
   
   function Mix (Self : in out Quadcopter_Cross_Mixer; Throttle : Float; Roll_PID_Output : Float;
                 Pitch_PID_Output : Float; Yaw_Rate_PID_Output : Float) return Real_Vector is
   
      X : Float renames Roll_PID_Output;
      Y : Float renames Pitch_PID_Output;
      Z : Float renames Yaw_Rate_PID_Output; 
      
      Mix : Real_Vector (1 .. 4);
   
   begin
      
      Mix (1) := Utils.Clamp (Throttle - X - Y - Z, Self.ESC_Min_Pulse_Width, Self.ESC_Max_Pulse_Width);
      Mix (2) := Utils.Clamp (Throttle + X - Y + Z, Self.ESC_Min_Pulse_Width, Self.ESC_Max_Pulse_Width);
      Mix (3) := Utils.Clamp (Throttle + X + Y - Z, Self.ESC_Min_Pulse_Width, Self.ESC_Max_Pulse_Width);
      Mix (4) := Utils.Clamp (Throttle - X + Y + Z, Self.ESC_Min_Pulse_Width, Self.ESC_Max_Pulse_Width);
      
      return Mix;
      
   end Mix;

end Mixers;
