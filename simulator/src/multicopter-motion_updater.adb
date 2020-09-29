package body Multicopter.Motion_Updater is

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

      Sample_Time : constant Float := Float (Self.Release_Interval / Milliseconds (1)) * 0.001;

      New_Forces_And_Moments : Real_Vector (1 .. 6);

      New_Linear_And_Angular_Velocities : Real_Vector (1 .. 6);
      
      New_Position_And_Orientation : Real_Vector (1 .. 6);

      Angular_Velocities : Real_Vector (1 .. Actuators.Number_Of_Actuators);

      Angular_Velocities_Squared : Real_Vector (1 .. Actuators.Number_Of_Actuators);

      Gravitational_Acceleration : constant Float := 9.80665;
      
      Global_Gravity_Vector : constant Real_Vector (1 .. 6) := (3 => - Multicopter.Mass * Gravitational_Acceleration,
                                                                others => 0.0);

   begin
      
      -- Motors.

      Angular_Velocities := Self.Motors.Get_Angular_Velocities;
      
      for I in Angular_Velocities_Squared'Range loop
         
         Angular_Velocities_Squared (I) := Angular_Velocities (I) ** 2.0;
         
      end loop;
            
      -- Forces and moments.
      
      New_Forces_And_Moments := Multicopter.T_Matrix * Angular_Velocities_Squared +
        Self.Motion.Get_Global_To_Local_Vector_Matrix * Global_Gravity_Vector;

      -- Linear and angular velocities.

      declare

         Term_1 : Real_Vector (1 .. 6);

         Term_2 : Real_Vector (1 .. 6);

      begin

         Term_1 := Self.Motion.Get_Forces_And_Moments * Sample_Time;

         Term_2 := Self.Motion.Get_C_Matrix * Self.Motion.Get_Linear_And_Angular_Velocities * Sample_Time;

         New_Linear_And_Angular_Velocities := Self.Motion.Get_Linear_And_Angular_Velocities +
           MRB_Matrix_Inverse * (Term_1 - Term_2);

      end;

      -- Position and orientation.

      New_Position_And_Orientation := Self.Motion.Get_Position_And_Orientation + 
        (Self.Motion.Get_J_Matrix * Self.Motion.Get_Linear_And_Angular_Velocities) * Sample_Time;
      
      -- Update.
      
      Self.Motion.Put_Forces_And_Moments (New_Forces_And_Moments);
      Self.Motion.Put_Linear_And_Angular_Velocities (New_Linear_And_Angular_Velocities);
      Self.Motion.Put_Position_And_Orientation (New_Position_And_Orientation);
      
   end On_Loop;

   ------------
   -- On_End --
   ------------

   procedure On_End (Self : in out Bundle) is
   begin
      null;
   end On_End;

end Multicopter.Motion_Updater;
