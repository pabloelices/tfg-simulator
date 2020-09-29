package Sensors.Absolute_Orientation_Sensor is

   protected type Agent (Ceiling: Priority) with Priority => Ceiling is new Absolute_Orientation_Sensor_Operations with
			
      overriding function Get_Roll return Float;
   
      overriding function Get_Pitch return Float;
   
      overriding function Get_Yaw_Rate return Float;
      
      overriding procedure Put_Roll (Roll : Float);

      overriding procedure Put_Pitch (Pitch : Float);

      overriding procedure Put_Yaw_Rate (Yaw_Rate : Float);
      
   private
      
      Roll : Float := 0.0;
      
      Pitch : Float := 0.0;
      
      Yaw_Rate : Float := 0.0;
		      		
   end Agent;

end Sensors.Absolute_Orientation_Sensor;
