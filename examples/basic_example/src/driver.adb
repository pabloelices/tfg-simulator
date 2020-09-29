package body Driver is

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

      Throttle_Reference : constant Float := 1500.0;
      Roll_Reference : Float;
      Pitch_Reference : constant Float := Utils.Degrees_To_Radians (0.0);
      Yaw_Rate_Reference : constant Float := Utils.Degrees_To_Radians (0.0);
      
   begin
      
      Roll_Reference := Utils.Degrees_To_Radians (2.5 * Float (Elapsed_Time / Milliseconds (1)) * 0.001);
      
      Self.References.Update (Throttle_Reference, Roll_Reference, Pitch_Reference, Yaw_Rate_Reference);
      
   end On_Loop;
   
   ------------
   -- On_End --
   ------------

   procedure On_End (Self : in out Bundle) is
   begin
      null;
   end On_End;
   
end Driver;
