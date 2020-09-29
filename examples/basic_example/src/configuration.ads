with Ada.Real_Time; use Ada.Real_Time;
with Ada.Text_IO; use Ada.Text_IO;

with System; use System;

with Actuators.Electronic_Speed_Controllers;
with Actuators.Motors;
with Actuators.Motors_Updater;
with Cyclics;
with Flight_Controller.Control_Algorithm;
with Flight_Controller.References;
with Logging.Logger;
with Mixers;
with Multicopter.Motion;
with Multicopter.Motion_Updater;
with PID_Controllers;
with Sensors.Absolute_Orientation_Sensor;
with Sensors.Absolute_Orientation_Sensor_Updater;

with Driver;

package Configuration is
   
   ----------------
   -- Simulation --
   ----------------

   Simulation_Time : constant Time_Span := Seconds (10);

   File_Path : aliased String := "./test_7.csv";

   Roll_PID_KP : constant Float := 45.0;
   Roll_PID_KI : constant Float := 1.75;
   Roll_PID_KD : constant Float := 20.0;

   Pitch_PID_KP : constant Float := 45.0;
   Pitch_PID_KI : constant Float := 1.75;
   Pitch_PID_KD : constant Float := 20.0;

   Yaw_Rate_PID_KP : constant Float := 20.0;
   Yaw_Rate_PID_KI : constant Float := 0.05;
   Yaw_Rate_PID_KD : constant Float := 2.0;

   PID_Min_Output : constant Float := -500.0;
   PID_Max_Output : constant Float := +500.0;
   
   -----------------------
   -- Release Intervals --
   -----------------------

   Motors_Updater_Release_Interval : constant Time_Span := Microseconds (100);
   
   Motion_Updater_Release_Interval : constant Time_Span := Milliseconds (5);
   
   Control_Algorithm_Release_Interval : constant Time_Span := Milliseconds (10);
   
   Absolute_Orientation_Sensor_Updater_Release_Interval : constant Time_Span := Milliseconds (10);
   
   Logger_Release_Interval : constant Time_Span := Milliseconds (50);
   
   Driver_Release_Interval : constant Time_Span := Milliseconds (60);
   
   ----------------
   -- Priorities --
   ----------------

   Motors_Updater_Priority : constant Priority := 10;
   
   Motion_Updater_Priority : constant Priority := 9;
   
   Control_Algorithm_Priority : constant Priority := 8;
   
   Absolute_Orientation_Sensor_Updater_Priority : constant Priority := 7;
   
   Logger_Priority : constant Priority := 6;
   
   Driver_Priority : constant Priority := 5;

   --------------
   -- Ceilings --
   --------------

   ESCs_Ceiling : constant Priority := 10;                   -- max{8, 10, 5} = 10.
   
   Motors_Ceiling : constant Priority := 10;                 -- max{10, 9, 6} = 10.
   
   Motion_Ceiling: constant Priority := 9;                   -- max{9, 7, 6} = 9. 
   
   References_Ceiling : constant Priority := 8;              -- max{5, 8, 6} = 8.
   
   Absolute_Orientation_Sensor_Ceiling: constant Priority := 8; -- max{7, 8, 6} = 8. 

   ------------
   -- Agents --
   ------------

   ESCs_Agent : aliased Actuators.Electronic_Speed_Controllers.Agent (Ceiling => ESCs_Ceiling);
   
   Motors_Agent : aliased Actuators.Motors.Agent (Ceiling => Motors_Ceiling);
   
   Motion_Agent : aliased Multicopter.Motion.Agent (Ceiling => Motion_Ceiling);
   
   References_Agent : aliased Flight_Controller.References.Agent (Ceiling => References_Ceiling);
   
   Absolute_Orientation_Sensor_Agent : aliased Sensors.Absolute_Orientation_Sensor.Agent (Ceiling => Absolute_Orientation_Sensor_Ceiling);
   
   -----------
   -- Other --
   -----------
   
   PID_Controllers_Sample_Time : constant Float := Float (Control_Algorithm_Release_Interval / Milliseconds (1)) * 0.001;
   
   Roll_PID : aliased PID_Controllers.Parallel_PID_Controller := PID_Controllers.Create (Roll_PID_KP,
                                                                                         Roll_PID_KI,
                                                                                         Roll_PID_KD,
                                                                                         PID_Controllers_Sample_Time,
                                                                                         PID_Min_Output,
                                                                                         PID_Max_Output);
   
   Pitch_PID : aliased PID_Controllers.Parallel_PID_Controller := PID_Controllers.Create (Pitch_PID_KP,
                                                                                          Pitch_PID_KI,
                                                                                          Pitch_PID_KD,
                                                                                          PID_Controllers_Sample_Time,
                                                                                          PID_Min_Output,
                                                                                          PID_Max_Output);
   
   Yaw_Rate_PID : aliased PID_Controllers.Parallel_PID_Controller := PID_Controllers.Create (Yaw_Rate_PID_KP,
                                                                                             Yaw_Rate_PID_KI,
                                                                                             Yaw_Rate_PID_KD,
                                                                                             PID_Controllers_Sample_Time,
                                                                                             PID_Min_Output,
                                                                                             PID_Max_Output);
   
   Quadcopter_Cross_Mixer : aliased Mixers.Quadcopter_Cross_Mixer := Mixers.Create (Actuators.ESC_Min_Pulse_Width,
                                                                                    Actuators.ESC_Max_Pulse_Width);
   
   File_Handler : aliased File_Type;
   
   -------------
   -- Bundles --
   -------------

   Driver_Bundle : aliased Driver.Bundle :=
     
     (Task_Priority => Driver_Priority,
      Release_Interval => Driver_Release_Interval,
      Task_Duration => Simulation_Time,
      References => References_Agent'Access);
   
   Control_Algorithm_Bundle : aliased Flight_Controller.Control_Algorithm.Bundle :=
     
     (Task_Priority => Control_Algorithm_Priority,
      Release_Interval => Control_Algorithm_Release_Interval,
      Task_Duration => Simulation_Time,
      Roll_PID => Roll_PID'Access,
      Pitch_PID => Pitch_PID'Access,
      Yaw_Rate_PID => Yaw_Rate_PID'Access,
      Quadcopter_Cross_Mixer => Quadcopter_Cross_Mixer'Access,
      References => References_Agent'Access,
      ESCs => ESCs_Agent'Access,
      Absolute_Orientation_Sensor => Absolute_Orientation_Sensor_Agent'Access);
   
   Motors_Updater_Bundle : aliased Actuators.Motors_Updater.Bundle :=
     
     (Task_Priority => Motors_Updater_Priority,
      Release_Interval => Motors_Updater_Release_Interval,
      Task_Duration => Simulation_Time,
      ESCs => ESCs_Agent'Access,
      Motors => Motors_Agent'Access);
   
   Motion_Updater_Bundle : aliased Multicopter.Motion_Updater.Bundle :=

     (Task_Priority => Motion_Updater_Priority,
      Release_Interval => Motion_Updater_Release_Interval,
      Task_Duration => Simulation_Time,
      Motors => Motors_Agent'Access,
      Motion => Motion_Agent'Access);
   
   Absolute_Orientation_Sensor_Updater_Bundle : aliased Sensors.Absolute_Orientation_Sensor_Updater.Bundle :=

     (Task_Priority => Absolute_Orientation_Sensor_Updater_Priority,
      Release_Interval => Absolute_Orientation_Sensor_Updater_Release_Interval,
      Task_Duration => Simulation_Time,
      Motion => Motion_Agent'Access,
      Absolute_Orientation_Sensor => Absolute_Orientation_Sensor_Agent'Access);

   Logger_Bundle : aliased Logging.Logger.Bundle :=

     (Task_Priority => Logger_Priority,
      Release_Interval => Logger_Release_Interval,
      Task_Duration => Simulation_Time,
      File_Handler => File_Handler'Access,
      File_Path => File_Path'Access,
      References => References_Agent'Access,
      ESCs => ESCs_Agent'Access,
      Motors => Motors_Agent'Access,
      Motion => Motion_Agent'Access,
      Absolute_Orientation_Sensor => Absolute_Orientation_Sensor_Agent'Access);
   
   -----------
   -- Tasks --
   -----------

   Driver_Task : Cyclics.Cyclic (Driver_Bundle'Access);
   
   Control_Algorithm_Task : Cyclics.Cyclic (Control_Algorithm_Bundle'Access);
   
   Motors_Updater_Task : Cyclics.Cyclic (Motors_Updater_Bundle'Access);
   
   Motion_Updater_Task : Cyclics.Cyclic (Motion_Updater_Bundle'Access);
   
   Absolute_Orientation_Sensor_Updater_Task : Cyclics.Cyclic (Absolute_Orientation_Sensor_Updater_Bundle'Access);
   
   Logger_Task : Cyclics.Cyclic (Logger_Bundle'Access);

end Configuration;
