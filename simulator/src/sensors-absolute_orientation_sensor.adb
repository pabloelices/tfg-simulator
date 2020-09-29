package body Sensors.Absolute_Orientation_Sensor is

   -----------
   -- Agent --
   -----------

   protected body Agent is

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

      --------------
      -- Put_Roll --
      --------------

      procedure Put_Roll (Roll : Float) is
      begin
         Agent.Roll := Roll;
      end Put_Roll;

      ---------------
      -- Put_Pitch --
      ---------------

      procedure Put_Pitch (Pitch : Float) is
      begin
         Agent.Pitch := Pitch;
      end Put_Pitch;

      ------------------
      -- Put_Yaw_Rate --
      ------------------

      procedure Put_Yaw_Rate (Yaw_Rate : Float) is
      begin
         Agent.Yaw_Rate := Yaw_Rate;
      end Put_Yaw_Rate;

   end Agent;

end Sensors.Absolute_Orientation_Sensor;
