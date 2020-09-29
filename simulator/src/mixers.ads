with Ada.Numerics.Real_Arrays; use Ada.Numerics.Real_Arrays;

with Utils;

package Mixers is

   Ilegal_Output_Limits : Exception;
   
   type Quadcopter_Cross_Mixer is tagged private;

   type Quadcopter_Cross_Mixer_Access is access all Quadcopter_Cross_Mixer'Class;

   function Create (ESC_Min_Pulse_Width : Float; ESC_Max_Pulse_Width : Float) return Quadcopter_Cross_Mixer;

   function Mix (Self : in out Quadcopter_Cross_Mixer; Throttle : Float; Roll_PID_Output : Float;
                 Pitch_PID_Output : Float; Yaw_Rate_PID_Output : Float) return Real_Vector;

private

   type Quadcopter_Cross_Mixer is tagged

      record

         ESC_Min_Pulse_Width : Float;
         ESC_Max_Pulse_Width : Float;

      end record;

end Mixers;
