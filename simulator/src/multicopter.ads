with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada.Numerics.Real_Arrays; use Ada.Numerics.Real_Arrays;
with Ada.Real_Time; use Ada.Real_Time;

with System; use System;

with Actuators;
with Cyclics;
with Utils;

package Multicopter is
      
   ---------------
   -- Constants --
   ---------------
   
   Mass : constant Float := 0.848;

   L : constant Float := 0.225;
   
   B : constant Float := 0.00000298;

   K : constant Float := 0.000000114;
      
   Alpha : constant Float := (Sqrt (2.0) / 2.0) * L * B;
   
   T_Matrix : constant Real_Matrix (1 .. 6, 1 .. 4) := ((0.0, 0.0, 0.0, 0.0),
                                                        (0.0, 0.0, 0.0, 0.0),
                                                        (B, B, B, B),
                                                        (-Alpha, +Alpha, +Alpha, -Alpha),
                                                        (-Alpha, -Alpha, +Alpha, +Alpha),
                                                        (-K, +K, -K, +K));
   
   Inertia_Tensor: constant Real_Matrix (1 .. 3, 1 .. 3) := ((0.008658454666667, 0.0, 0.0),
                                                             (0.0, 0.009249857333333, 0.0),
                                                             (0.0, 0.0, 0.00077032266));
   
   MRB_Matrix : constant Real_Matrix (1 .. 6, 1 .. 6) := ((Mass, 0.0, 0.0, 0.0, 0.0, 0.0),
                                                          (0.0, Mass, 0.0, 0.0, 0.0, 0.0),
                                                          (0.0, 0.0, Mass, 0.0, 0.0, 0.0),
                                                          (0.0, 0.0, 0.0, Inertia_Tensor (1, 1), 0.0, 0.0),
                                                          (0.0, 0.0, 0.0, 0.0, Inertia_Tensor (2, 2), 0.0),
                                                          (0.0, 0.0, 0.0, 0.0, 0.0, Inertia_Tensor (3, 3)));
   
   MRB_Matrix_Inverse : constant Real_Matrix (1 .. 6, 1 .. 6) := Inverse (MRB_Matrix);
   
   ------------
   -- Motion --
   ------------
   
   -- Motion_Reader interface.
	
   type Motion_Reader is synchronized interface;
	
   function Get_Forces_And_Moments (Self : Motion_Reader) return Real_Vector is abstract;

   function Get_Linear_And_Angular_Velocities (Self : Motion_Reader) return Real_Vector is abstract;

   function Get_Position_And_Orientation (Self : Motion_Reader) return Real_Vector is abstract;
   	
   type Any_Motion_Reader is access all Motion_Reader'Class;
	
   -- Motion_Operations interface.
	
   type Motion_Operations is synchronized interface and Motion_Reader;
	  
   procedure Put_Forces_And_Moments (Self : in out Motion_Operations; Forces_And_Moments : Real_Vector) is abstract;

   procedure Put_Linear_And_Angular_Velocities (Self : in out Motion_Operations;
                                                Linear_And_Angular_Velocities : Real_Vector) is abstract;

   procedure Put_Position_And_Orientation (Self : in out Motion_Operations;
                                           Position_And_Orientation : Real_Vector) is abstract;
      
   function Get_C_Matrix (Self : Motion_Operations) return Real_Matrix is abstract;
   
   function Get_J_1_Matrix (Self : Motion_Operations) return Real_Matrix is abstract;

   function Get_J_2_Matrix (Self : Motion_Operations) return Real_Matrix is abstract;
   
   function Get_J_Matrix (Self : Motion_Operations) return Real_Matrix is abstract; 

   function Get_Global_To_Local_Vector_Matrix (Self : Motion_Operations) return Real_Matrix is abstract;
   
   type Any_Motion_Operations is access all Motion_Operations'Class;

end Multicopter;
