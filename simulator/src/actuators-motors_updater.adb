package body Actuators.Motors_Updater is

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

      ESCs_Pulse_Widths : Real_Vector (1 .. Actuators.Number_Of_Actuators);

      Motors_New_Angular_Velocity_References : Real_Vector (1 .. Actuators.Number_Of_Actuators);

      A : constant Float :=  -Log (0.02) / Actuators.Motors_Settling_Time;

      Sample_Time : constant Float := Float (Self.Release_Interval / Microseconds (1)) * 0.000001;

      Alpha : constant Float := Exp (-A * Sample_Time);

      Beta : constant Float := 1.0 - Alpha;

   begin

      -- Map pulse widths to angular velocity references.

      ESCs_Pulse_Widths := Self.ESCs.Get_Pulse_Widths;

      for I in Motors_New_Angular_Velocity_References'First .. Motors_New_Angular_Velocity_References'Last loop

         Motors_New_Angular_Velocity_References (I) := Utils.Linear_Interpolation (ESCs_Pulse_Widths (I),
                                                                                   Actuators.ESC_Min_Pulse_Width,
                                                                                   Actuators.ESC_Max_Pulse_Width,
                                                                                   Actuators.Motor_Min_Angular_Velocity,
                                                                                   Actuators.Motor_Max_Angular_Velocity);

      end loop;

      Self.Motors.Put_Angular_Velocity_References (Motors_New_Angular_Velocity_References);

      -- Update angular velocities.

      Self.Motors.Put_Angular_Velocities (Alpha * Self.Motors.Get_Angular_Velocities +
                                          Beta * Self.Motors.Get_Angular_Velocity_References);

   end On_Loop;

   ------------
   -- On_End --
   ------------

   procedure On_End (Self : in out Bundle) is
   begin
      null;
   end On_End;

end Actuators.Motors_Updater;
