package body Flight_Controller.References is

   -----------
   -- Agent --
   -----------
   
   protected body Agent is

      ------------------
      -- Get_Throttle --
      ------------------

      function Get_Throttle return Float is
      begin
         return Agent.Throttle;
      end Get_Throttle;

      --------------
      -- Get_Roll --
      --------------

      function Get_Roll return Float is
      begin
         return Agent.Roll;
      end Get_Roll;

      ---------------
      -- Get_Pitch --
      ---------------

      function Get_Pitch return Float is
      begin
         return Agent.Pitch;
      end Get_Pitch;

      ------------------
      -- Get_Yaw_Rate --
      ------------------

      function Get_Yaw_Rate return Float is
      begin
         return Agent.Yaw_Rate;
      end Get_Yaw_Rate;

      ------------
      -- Update --
      ------------

      procedure Update (Throttle : Float; Roll : Float; Pitch : Float; Yaw_Rate : Float) is
      begin
         
         Agent.Throttle := Utils.Clamp (Throttle, Flight_Controller.Min_Throttle, Flight_Controller.Max_Throttle);
         Agent.Roll := Utils.Clamp (Roll, Flight_Controller.Min_Roll, Flight_Controller.Max_Roll);
         Agent.Pitch := Utils.Clamp (Pitch, Flight_Controller.Min_Pitch, Flight_Controller.Max_Pitch);
         Agent.Yaw_Rate := Utils.Clamp (Yaw_Rate, Flight_Controller.Min_Yaw_Rate, Flight_Controller.Max_Yaw_Rate);
                  
      end Update;
  
   end Agent;

end Flight_Controller.References;
