package body Utils is

   -----------
   -- Clamp --
   -----------
      
   function Clamp (N : Float; Min : Float; Max: Float) return Float is
   begin
         
      if N > Max then
            
         return Max;
            
      elsif N < Min then
            
         return Min;
            
      else
            
         return N;
            
      end if;
         
   end Clamp;

   -----------
   -- Clamp --
   -----------
   
   function Clamp (N : Real_Vector; Min : Float; Max : Float) return Real_Vector is

      N_Clampled : Real_Vector (N'First .. N'Last);

   begin
      
      for I in N_Clampled'Range loop
         
         N_Clampled (I) := Clamp (N (I), Min, Max);
         
      end loop;
      
      return N_Clampled;
      
   end Clamp;	
   
   --------------------------
   -- Linear_Interpolation --
   --------------------------

   function Linear_Interpolation (X, X_0, X_1, Y_0, Y_1 : Float) return Float is
   begin      
      return (Y_0 * (X_1 - X) + Y_1 * (X - X_0)) / (X_1 - X_0);
   end Linear_Interpolation;
   
   ------------------------
   -- Degrees_To_Radians --
   ------------------------
   
   function Degrees_To_Radians (Degrees : Float) return Float is
   begin
      return Degrees * (Ada.Numerics.Pi / 180.0);
   end Degrees_To_Radians;
      
end Utils;
