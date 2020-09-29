with Ada.Real_Time; use Ada.Real_Time;

with System; use System;

package Cyclics is

   type Bundle is abstract tagged limited

      record

         Task_Priority : Priority;

         Release_Interval : Time_Span;

         Task_Duration : Time_Span;

      end record;

   procedure On_Start (Self : in out Bundle) is abstract;

   procedure On_Loop (Self : in out Bundle; Elapsed_Time : Time_Span) is abstract;

   procedure On_End (Self : in out Bundle) is abstract;

   type Any_Bundle is access all Bundle'Class;

   task type Cyclic (Bundle : Any_Bundle) is

      pragma Priority (Bundle.Task_Priority);

   end Cyclic;

end Cyclics;
