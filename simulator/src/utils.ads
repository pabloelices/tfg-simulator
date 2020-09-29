with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada.Numerics.Real_Arrays; use Ada.Numerics.Real_Arrays;

package Utils is
   
   function Clamp (N : Float; Min : Float; Max : Float) return Float;

   function Clamp (N : Real_Vector; Min : Float; Max : Float) return Real_Vector;

   function Linear_Interpolation (X, X_0, X_1, Y_0, Y_1 : Float) return Float;
   
   function Degrees_To_Radians (Degrees : Float) return Float;
   
end Utils;
