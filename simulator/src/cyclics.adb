package body Cyclics is

   ------------
   -- Cyclic --
   ------------

   task body Cyclic is

      Next_Release : Time;

      Start_Time : Time;

   begin

      Start_Time := Clock;

      Bundle.On_Start;

      Next_Release := Clock + Bundle.Release_Interval;

      loop

         Bundle.On_Loop (Clock - Start_Time);

         delay until Next_Release;

         Next_Release := Next_Release + Bundle.Release_Interval;

         exit when Clock - Start_Time >= Bundle.Task_Duration;

      end loop;

      Bundle.On_End;

   end Cyclic;

end Cyclics;
