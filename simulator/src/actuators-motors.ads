package Actuators.Motors is

   protected type Agent (Ceiling: Priority) with Priority => Ceiling is new Motors_Operations with
      
      overriding function Get_Angular_Velocity_References return Real_Vector;
      
      overriding function Get_Angular_Velocities return Real_Vector;

      overriding procedure Put_Angular_Velocity_References (Angular_Velocity_References : Real_Vector);
          
      overriding procedure Put_Angular_Velocities (Angular_Velocities : Real_Vector);
      
   private
      
      Angular_Velocity_References : Real_Vector (1 .. Actuators.Number_Of_Actuators) :=
        (others => Actuators.Motor_Min_Angular_Velocity);
		      		
      Angular_Velocities : Real_Vector (1 .. Actuators.Number_Of_Actuators) := 
        (others => Actuators.Motor_Min_Angular_Velocity);
      
   end Agent;

end Actuators.Motors;
