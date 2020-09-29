with Utils;

package PID_Controllers is

   Ilegal_Sample_Time : Exception;
   Ilegal_Output_Limits : Exception;

   type Parallel_PID_Controller is tagged private;

   type Parallel_PID_Controller_Access is access all Parallel_PID_Controller'Class;

   function Create (KP : Float; KI : Float; KD : Float; Sample_Time : Float; Min_Output : Float;
                    Max_Output : Float) return Parallel_PID_Controller;

   function Update (Self : in out Parallel_PID_Controller; Reference : Float; Measured_Value : Float) return Float;

   procedure Reset (Self : in out Parallel_PID_Controller);

private

   type Parallel_PID_Controller is tagged

      record

         KP : Float;
         KI : Float;
         KD : Float;

         Sample_Time : Float;

         Min_Output : Float;
         Max_Output : Float;

         Past_Error : Float;

         Past_Integral_Output : Float;

      end record;

end PID_Controllers;
