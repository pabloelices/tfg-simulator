package body Sensors.Absolute_Orientation_Sensor_Updater is

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
   begin

      Self.Absolute_Orientation_Sensor.Put_Roll (Self.Motion.Get_Position_And_Orientation (4));
      Self.Absolute_Orientation_Sensor.Put_Pitch (Self.Motion.Get_Position_And_Orientation (5));
      Self.Absolute_Orientation_Sensor.Put_Yaw_Rate (Self.Motion.Get_Linear_And_Angular_Velocities (6));

   end On_Loop;

   ------------
   -- On_End --
   ------------

   procedure On_End (Self : in out Bundle) is
   begin
      null;
   end On_End;

end Sensors.Absolute_Orientation_Sensor_Updater;
