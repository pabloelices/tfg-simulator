with Ada.Text_IO; use Ada.Text_IO;

package body Multicopter.Motion is

   -----------
   -- Agent --
   -----------
   
   protected body Agent is

      ----------------------------
      -- Get_Forces_And_Moments --
      ----------------------------

      function Get_Forces_And_Moments return Real_Vector is
      begin
         return Agent.Forces_And_Moments;
      end Get_Forces_And_Moments;

      ---------------------------------------
      -- Get_Linear_And_Angular_Velocities --
      ---------------------------------------

      function Get_Linear_And_Angular_Velocities return Real_Vector is
      begin
         return Agent.Linear_And_Angular_Velocities;
      end Get_Linear_And_Angular_Velocities;

      ----------------------------------
      -- Get_Position_And_Orientation --
      ----------------------------------

      function Get_Position_And_Orientation return Real_Vector is
      begin
         return Agent.Position_And_Orientation;
      end Get_Position_And_Orientation;

      ----------------------------
      -- Put_Forces_And_Moments --
      ----------------------------

      procedure Put_Forces_And_Moments (Forces_And_Moments : Real_Vector) is
      begin
         Agent.Forces_And_Moments := Forces_And_Moments;
      end Put_Forces_And_Moments;

      ---------------------------------------
      -- Put_Linear_And_Angular_Velocities --
      ---------------------------------------

      procedure Put_Linear_And_Angular_Velocities (Linear_And_Angular_Velocities : Real_Vector) is
      begin
         Agent.Linear_And_Angular_Velocities := Linear_And_Angular_Velocities;
      end Put_Linear_And_Angular_Velocities;

      ----------------------------------
      -- Put_Position_And_Orientation --
      ----------------------------------

      procedure Put_Position_And_Orientation (Position_And_Orientation : Real_Vector) is
      begin
         Agent.Position_And_Orientation := Position_And_Orientation;
      end Put_Position_And_Orientation;
      
      ------------------
      -- Get_C_Matrix --
      ------------------

      function Get_C_Matrix return Real_Matrix is

         U : constant Float := Agent.Linear_And_Angular_Velocities (1);
         V : constant Float := Agent.Linear_And_Angular_Velocities (2);
         W : constant Float := Agent.Linear_And_Angular_Velocities (3);
         P : constant Float := Agent.Linear_And_Angular_Velocities (4);
         Q : constant Float := Agent.Linear_And_Angular_Velocities (5);
         R : constant Float := Agent.Linear_And_Angular_Velocities (6);

         M : constant Float := Multicopter.Mass;

         I_X : constant Float := Multicopter.Inertia_Tensor (1, 1);
         I_Y : constant Float := Multicopter.Inertia_Tensor (2, 2);
         I_Z : constant Float := Multicopter.Inertia_Tensor (3, 3);

         C_Matrix : constant Real_Matrix (1 .. 6, 1 .. 6) := ((0.0, 0.0, 0.0, 0.0, M * W, -M * V),
                                                              (0.0, 0.0, 0.0, -M * W, 0.0, M * U),
                                                              (0.0, 0.0, 0.0, M * V, -M * U, 0.0),
                                                              (0.0, M * W, -M * V, 0.0, I_Z * R, -I_Y * Q),
                                                              (-M * W, 0.0, M * U, -I_Z * R, 0.0, I_X * P),
                                                              (M * V, -M * U, 0.0, I_Y * Q, -I_X * P, 0.0));

      begin

         return C_Matrix;

      end Get_C_Matrix;

      --------------------
      -- Get_J_1_Matrix --
      --------------------
      
      function Get_J_1_Matrix return Real_Matrix is
         
         Phi : constant Float := Agent.Position_And_Orientation (4);
         Theta : constant Float := Agent.Position_And_Orientation (5);
         Psi : constant Float := Agent.Position_And_Orientation (6);

         S_Phi : constant Float := Sin (Phi);
         C_Phi : constant Float := Cos (Phi);

         S_Theta : constant Float := Sin (Theta);
         C_Theta : constant Float := Cos (Theta);

         S_Psi : constant Float := Sin (Psi);
         C_Psi : constant Float := Cos (Psi);

         J_1_Matrix : constant Real_Matrix (1 .. 3, 1 .. 3) := ((C_Psi * C_Theta,
                                                                -S_Psi * C_Phi + C_Psi * S_Theta * S_Phi,
                                                                S_Psi * S_Phi + C_Psi * C_Phi * S_Theta),

                                                                (S_Psi * C_Theta,
                                                                 C_Psi * C_Phi + S_Phi * S_Theta * S_Psi,
                                                                 -C_Psi * S_Phi + S_Theta * S_Psi * C_Phi),

                                                                (-S_Theta,
                                                                 C_Theta * S_Phi,
                                                                 C_Theta * C_Phi));
         
      begin
         
         return J_1_Matrix;
         
      end Get_J_1_Matrix;

      --------------------
      -- Get_J_2_Matrix --
      --------------------
      
      function Get_J_2_Matrix return Real_Matrix is

         Phi : constant Float := Agent.Position_And_Orientation (4);
         Theta : constant Float := Agent.Position_And_Orientation (5);
         Psi : constant Float := Agent.Position_And_Orientation (6);
         
         Sin_Phi : constant Float := Sin (Phi);
         Cos_Phi : constant Float := Cos (Phi);
         Cos_Theta : constant Float := Cos (Theta);
         Tan_Theta : constant Float := Tan (Theta);

         J_2_Matrix : constant Real_Matrix (1 .. 3, 1 .. 3) := ((1.0, Sin_Phi * Tan_Theta, Cos_Phi * Tan_Theta),
                                                                (0.0, Cos_Phi, -Sin_Phi),
                                                                (0.0, Sin_Phi / Cos_Theta, Cos_Phi / Cos_Theta));
         
      begin
         
         return J_2_Matrix;
         
      end Get_J_2_Matrix;
      
      ------------------
      -- Get_J_Matrix --
      ------------------

      function Get_J_Matrix return Real_Matrix is

         J_1_Matrix : constant Real_Matrix := Get_J_1_Matrix;

         J_2_Matrix : constant Real_Matrix := Get_J_2_Matrix;

         J_Matrix : Real_Matrix (1 .. 6, 1 .. 6);

      begin

         J_Matrix := (others => (others => 0.0));

         for I in 1 .. 3 loop

            for J in 1 .. 3 loop

               J_Matrix (I, J) := J_1_Matrix (I, J);

            end loop;

         end loop;

         for I in 4 .. 6 loop

            for J in 4 .. 6 loop

               J_Matrix (I, J) := J_2_Matrix (I - 3, J - 3);

            end loop;

         end loop;

         return J_Matrix;

      end Get_J_Matrix;

      ---------------------------------------
      -- Get_Global_To_Local_Vector_Matrix --
      ---------------------------------------
      
      function Get_Global_To_Local_Vector_Matrix return Real_Matrix is

         J_1_Matrix_Inverse : constant Real_Matrix (1 .. 3, 1 .. 3) := Transpose (Agent.Get_J_1_Matrix);
         
         Global_To_Local_Vector_Matrix : Real_Matrix (1 .. 6, 1 .. 6) := (others => (others => 0.0));

      begin
         
         for I in 1 .. 3 loop

            for J in 1 .. 3 loop

               Global_To_Local_Vector_Matrix (I, J) := J_1_Matrix_Inverse (I, J);

            end loop;

         end loop;
         
         return Global_To_Local_Vector_Matrix;
         
      end Get_Global_To_Local_Vector_Matrix;
      
   end Agent;

end Multicopter.Motion;
