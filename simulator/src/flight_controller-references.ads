package Flight_Controller.References is

   protected type Agent (Ceiling: Priority) with Priority => Ceiling is new References_Operations with
      
      overriding function Get_Throttle return Float;
   
      overriding function Get_Roll return Float;

      overriding function Get_Pitch return Float;
   
      overriding function Get_Yaw_Rate return Float;
            
      overriding procedure Update (Throttle : Float; Roll : Float; Pitch : Float; Yaw_Rate : Float);
      
   private
      
      Throttle : Float := Flight_Controller.Min_Throttle;
      
      Roll : Float := 0.0;
      
      Pitch : Float := 0.0;
      
      Yaw_Rate : Float := 0.0;
		      		
   end Agent;

end Flight_Controller.References;
