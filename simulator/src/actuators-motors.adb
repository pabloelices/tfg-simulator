package body Actuators.Motors is

   -----------
   -- Agent --
   -----------

   protected body Agent is

      -------------------------------------
      -- Get_Angular_Velocity_References --
      -------------------------------------

      function Get_Angular_Velocity_References return Real_Vector is
      begin
         return Agent.Angular_Velocity_References;
      end Get_Angular_Velocity_References;

      ----------------------------
      -- Get_Angular_Velocities --
      ----------------------------

      function Get_Angular_Velocities return Real_Vector is
      begin
         return Agent.Angular_Velocities;
      end Get_Angular_Velocities;

      -------------------------------------
      -- Put_Angular_Velocity_References --
      -------------------------------------

      procedure Put_Angular_Velocity_References (Angular_Velocity_References : Real_Vector) is
      begin

         Agent.Angular_Velocity_References := Utils.Clamp (Angular_Velocity_References,
                                                           Actuators.Motor_Min_Angular_Velocity,
                                                           Actuators.Motor_Max_Angular_Velocity);
      end Put_Angular_Velocity_References;

      ----------------------------
      -- Put_Angular_Velocities --
      ----------------------------

      procedure Put_Angular_Velocities (Angular_Velocities : Real_Vector) is
      begin

         Agent.Angular_Velocities := Utils.Clamp (Angular_Velocities,
                                                  Actuators.Motor_Min_Angular_Velocity,
                                                  Actuators.Motor_Max_Angular_Velocity);

      end Put_Angular_Velocities;

   end Agent;

end Actuators.Motors;
