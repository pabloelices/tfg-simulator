with Ada.Numerics.Real_Arrays; use Ada.Numerics.Real_Arrays;
with Ada.Real_Time; use Ada.Real_Time;

with System; use System;

with Actuators;
with Cyclics;
with Mixers;
with PID_Controllers;
with Sensors;
with Utils;

package Flight_Controller is
   
   ---------------
   -- Constants --
   ---------------
   
   Min_Throttle : constant Float := 1000.0;

   Max_Throttle : constant Float := 2000.0;

   Min_Roll : constant Float := Utils.Degrees_To_Radians (-25.0);
   
   Max_Roll : constant Float := Utils.Degrees_To_Radians (+25.0);
   
   Min_Pitch : constant Float := Utils.Degrees_To_Radians (-25.0);

   Max_Pitch : constant Float := Utils.Degrees_To_Radians (+25.0);

   Min_Yaw_Rate : constant Float := Utils.Degrees_To_Radians (-180.0);

   Max_Yaw_Rate : constant Float := Utils.Degrees_To_Radians (+180.0);
   
   ----------------
   -- References --
   ----------------
   
   -- References_Reader interface.
   
   type References_Reader is synchronized interface;
   
   function Get_Throttle (Self: References_Reader) return Float is abstract;
   
   function Get_Roll (Self: References_Reader) return Float is abstract;

   function Get_Pitch (Self: References_Reader) return Float is abstract;
   
   function Get_Yaw_Rate (Self: References_Reader) return Float is abstract;
   
   type Any_References_Reader is access all References_Reader'Class;
   
   -- References_Writer interface.
   
   type References_Writer is synchronized interface;
   
   procedure Update (Self: in out References_Writer; Throttle, Roll, Pitch, Yaw_Rate : Float) is abstract;
   
   type Any_References_Writer is access all References_Writer'Class;

   -- References_Operations interface.
   
   type References_Operations is synchronized interface and References_Reader and References_Writer;
   
   type Any_References_Operations is access all References_Operations'Class;
   
end Flight_Controller;
