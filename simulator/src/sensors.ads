with Ada.Real_Time; use Ada.Real_Time;

with System; use System;

with Cyclics;
with Multicopter;

package Sensors is
   
   ---------------------------------
   -- Absolute orientation sensor --
   ---------------------------------
   
   -- Absolute_Orientation_Sensor_Reader interface.
	
   type Absolute_Orientation_Sensor_Reader is synchronized interface;
	
   function Get_Roll (Self : Absolute_Orientation_Sensor_Reader) return Float is abstract;
   
   function Get_Pitch (Self : Absolute_Orientation_Sensor_Reader) return Float is abstract;
   
   function Get_Yaw_Rate (Self : Absolute_Orientation_Sensor_Reader) return Float is abstract;
   	
   type Any_Absolute_Orientation_Sensor_Reader is access all Absolute_Orientation_Sensor_Reader'Class;
	
   -- Absolute_Orientation_Sensor_Operations interface.
	
   type Absolute_Orientation_Sensor_Operations is synchronized interface and Absolute_Orientation_Sensor_Reader;
	   
   procedure Put_Roll (Self : in out Absolute_Orientation_Sensor_Operations; Roll : Float) is abstract;

   procedure Put_Pitch (Self : in out Absolute_Orientation_Sensor_Operations; Pitch : Float) is abstract;

   procedure Put_Yaw_Rate (Self : in out Absolute_Orientation_Sensor_Operations; Yaw_Rate : Float) is abstract;
   
   type Any_Absolute_Orientation_Sensor_Operations is access all Absolute_Orientation_Sensor_Operations'Class;
	
end Sensors;
