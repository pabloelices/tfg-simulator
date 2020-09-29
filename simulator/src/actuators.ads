with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada.Numerics.Real_Arrays; use Ada.Numerics.Real_Arrays;
with Ada.Real_Time; use Ada.Real_Time;

with System; use System;

with Cyclics;
with Utils;

package Actuators is

   ---------------
   -- Constants --
   ---------------
   
   Number_Of_Actuators : constant Positive := 4;

   ESC_Min_Pulse_Width : constant Float := 1000.0;
   
   ESC_Max_Pulse_Width : constant Float := 2000.0;
   
   Motor_Min_Angular_Velocity : constant Float := 0.0;
   
   Motor_Max_Angular_Velocity : constant Float := 1240.0;

   Motors_Settling_Time : constant Float := 0.250;
   
   ----------------------------------
   -- Electronic speed controllers --
   ----------------------------------
   
   -- ESCs_Reader interface.
	
   type ESCs_Reader is synchronized interface;
	
   function Get_Pulse_Widths (Self : ESCs_Reader) return Real_Vector is abstract;
   	
   type Any_ESCs_Reader is access all ESCs_Reader'Class;
	
   -- ESCs_Writer interface.
	
   type ESCs_Writer is synchronized interface;
	   
   procedure Put_Pulse_Widths (Self : in out ESCs_Writer; Pulse_Widths : Real_Vector) is abstract;
   
   type Any_ESCs_Writer is access all ESCs_Writer'Class;
	
   -- ESCs_Operations interface.
	
   type ESCs_Operations is synchronized interface and ESCs_Reader and ESCs_Writer;
	
   type Any_ESCs_Operations is access all ESCs_Operations'Class;

   ------------
   -- Motors --
   ------------
   
   -- Motors_Reader interface.
   
   type Motors_Reader is synchronized interface;
   
   function Get_Angular_Velocity_References (Self: Motors_Reader) return Real_Vector is abstract;
   
   function Get_Angular_Velocities (Self: Motors_Reader) return Real_Vector is abstract;
   
   type Any_Motors_Reader is access all Motors_Reader'Class;
      
   -- Motors_Operations interface.
   
   type Motors_Operations is synchronized interface and Motors_Reader;
      
   procedure Put_Angular_Velocity_References (Self : in out Motors_Operations;
                                              Angular_Velocity_References : Real_Vector) is abstract;
   
   procedure Put_Angular_Velocities (Self : in out Motors_Operations; Angular_Velocities : Real_Vector) is abstract;
   
   type Any_Motors_Operations is access all Motors_Operations'Class;
   
end Actuators;
