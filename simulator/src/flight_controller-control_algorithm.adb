package body Flight_Controller.Control_Algorithm is

   --------------
   -- On_Start --
   --------------

   procedure On_Start (Self : in out Bundle) is
   begin
      null;
   end On_Start;

   -------------
   -- On_Loop --
   -------------

   procedure On_Loop (Self : in out Bundle; Elapsed_Time : Time_Span) is
         
      Commanded_Throttle : Float;
      Commanded_Roll : Float;
      Commanded_Pitch : Float;
      Commanded_Yaw_Rate : Float;
      
      Measured_Roll : Float;
      Measured_Pitch : Float;
      Measured_Yaw_Rate : Float;
      
      Roll_PID_Output : Float;
      Pitch_PID_Output : Float;
      Yaw_Rate_PID_Output : Float;
            
      Mix : Real_Vector (1 .. Actuators.Number_Of_Actuators);
      
   begin
      
      -- Get commanded values.

      Commanded_Throttle := Self.References.Get_Throttle;
      Commanded_Roll := Self.References.Get_Roll;
      Commanded_Pitch := Self.References.Get_Pitch;
      Commanded_Yaw_Rate := Self.References.Get_Yaw_Rate;
      
      -- Get measured values.

      Measured_Roll := Self.Absolute_Orientation_Sensor.Get_Roll;
      Measured_Pitch := Self.Absolute_Orientation_Sensor.Get_Pitch;
      Measured_Yaw_Rate := Self.Absolute_Orientation_Sensor.Get_Yaw_Rate;
      
      -- Compute controller outputs.
      
      Roll_PID_Output := Self.Roll_PID.Update (Commanded_Roll, Measured_Roll);
      Pitch_PID_Output := Self.Pitch_PID.Update (Commanded_Pitch, Measured_Pitch);
      Yaw_Rate_PID_Output := Self.Yaw_Rate_PID.Update (Commanded_Yaw_Rate, Measured_Yaw_Rate);
      
      -- Mix throttle with PID outputs.
            
      Mix := Self.Quadcopter_Cross_Mixer.Mix (Commanded_Throttle, Roll_PID_Output, Pitch_PID_Output, Yaw_Rate_PID_Output);
      
      -- Write ESCs.

      Self.ESCs.Put_Pulse_Widths (Mix);
      
   end On_Loop;

   ------------
   -- On_End --
   ------------

   procedure On_End (Self : in out Bundle) is
   begin
      null;
   end On_End;

end Flight_Controller.Control_Algorithm;
