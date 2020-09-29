package Multicopter.Motion is

   protected type Agent (Ceiling: Priority) with Priority => Ceiling is new Motion_Operations with
      
      overriding function Get_Forces_And_Moments return Real_Vector;

      overriding function Get_Linear_And_Angular_Velocities return Real_Vector;

      overriding function Get_Position_And_Orientation return Real_Vector;

      overriding procedure Put_Forces_And_Moments (Forces_And_Moments : Real_Vector);

      overriding procedure Put_Linear_And_Angular_Velocities (Linear_And_Angular_Velocities : Real_Vector);

      overriding procedure Put_Position_And_Orientation (Position_And_Orientation : Real_Vector);
            
      overriding function Get_C_Matrix return Real_Matrix;
   
      overriding function Get_J_1_Matrix return Real_Matrix;

      overriding function Get_J_2_Matrix return Real_Matrix;
      
      overriding function Get_J_Matrix return Real_Matrix; 

      overriding function Get_Global_To_Local_Vector_Matrix return Real_Matrix;
      
   private
      
      Forces_And_Moments : Real_Vector (1 .. 6) := (others => 0.0);

      Linear_And_Angular_Velocities : Real_Vector (1 .. 6) := (others => 0.0);

      Position_And_Orientation : Real_Vector (1 .. 6) := (others => 0.0);
		      		
   end Agent;

end Multicopter.Motion;
