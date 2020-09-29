package body PID_Controllers is

   ------------
   -- Create --
   ------------

   function Create (KP : Float; KI : Float; KD : Float; Sample_Time : Float; Min_Output : Float;
                    Max_Output : Float) return Parallel_PID_Controller is      
   begin

      -- Validate Sample_Time.
      
      if Sample_Time = 0.0 then
         
         raise Ilegal_Sample_Time with "Sample time must be greater than 0";
         
      end if;
      
      -- Validate Min_Output and Max_Output.
      
      if not (Min_Output < Max_Output) then
         
         raise Ilegal_Output_Limits with "Min_Output must be lower than Max_Output";
         
      end if;
      
      -- Create and return.
      
      return (KP => KP, KI => KI, KD => KD, Sample_Time => Sample_Time, Min_Output => Min_Output,
              Max_Output => Max_Output, Past_Error => 0.0, Past_Integral_Output => 0.0);

   end Create;

   ------------
   -- Update --
   ------------

   function Update (Self : in out Parallel_PID_Controller; Reference : Float; Measured_Value : Float) return Float is

      Alpha : constant Float := (Self.Sample_Time / 2.0) * Self.KI;
      Beta : constant Float := (1.0 / Self.Sample_Time) * Self.KD;
      
      Error : Float;
      
      Proportional_Output : Float;
      Integral_Output : Float;
      Derivative_Output : Float;

      Integral_Min_Output : Float;
      Integral_Max_Output : Float;
      
      Total_Output : Float;
      
   begin

      -- Compute the error.
      
      Error := Reference - Measured_Value;

      -- Compute the output for each block.
      
      Proportional_Output := Self.KP * Error;
      Integral_Output := Self.Past_Integral_Output + Alpha * (Error + Self.Past_Error);
      Derivative_Output := Beta * (Error - Self.Past_Error);
      
      -- Anti-Windup.
      
      Integral_Min_Output := Float'Min (Self.Min_Output - (Proportional_Output + Derivative_Output), 0.0);
      Integral_Max_Output := Float'Max (Self.Max_Output - (Proportional_Output + Derivative_Output), 0.0);
      
      Integral_Output := Utils.Clamp (Integral_Output, Integral_Min_Output, Integral_Max_Output);

      -- Compute and limit the total output.
      
      Total_Output := Proportional_Output + Integral_Output + Derivative_Output;
      
      Total_Output := Utils.Clamp (Total_Output, Self.Min_Output, Self.Max_Output);
      
      -- Prepare the next iteration.
      
      Self.Past_Error := Error;
      Self.Past_Integral_Output := Integral_Output;

      -- Return the total output.
      
      return Total_Output;

   end Update;

   -----------
   -- Reset --
   -----------

   procedure Reset (Self : in out Parallel_PID_Controller) is
   begin
      
      -- Set to zero the memory components.
      
      Self.Past_Error := 0.0;
      Self.Past_Integral_Output := 0.0;

   end Reset;   

end PID_Controllers;
