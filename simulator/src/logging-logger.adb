package body Logging.Logger is

   --------------
   -- On_Start --
   --------------

   procedure On_Start (Self : in out Bundle) is
   begin

      Create (Self.File_Handler.all, Out_File, Self.File_Path.all);
      
      Put (Self.File_Handler.all, "Time,");

      Put (Self.File_Handler.all, "Throttle_Reference,Roll_Reference,Pitch_Reference,Yaw_Rate_Reference,");

      Put (Self.File_Handler.all, "ESC_1,ESC_2,ESC_3,ESC_4,");

      Put (Self.File_Handler.all, "Motor_1,Motor_2,Motor_3,Motor_4,");
      
      Put (Self.File_Handler.all, "X,Y,Z,K,M,N,u,v,w,p,q,r,x,y,z,phi,theta,psi,");
      
      Put (Self.File_Handler.all, "Sensor_Roll,Sensor_Pitch,Sensor_Yaw_Rate");
      
      New_Line (Self.File_Handler.all);
      
   end On_Start;

   -------------
   -- On_Loop --
   -------------

   procedure On_Loop (Self : in out Bundle; Elapsed_Time : Time_Span) is
      
      Elapsed_Time_Float : constant Float := Float (Elapsed_Time / Milliseconds (1)) * 0.001;

      Throttle_Reference : constant Float := Self.References.Get_Throttle;
      Roll_Reference : constant Float := Self.References.Get_Roll;
      Pitch_Reference : constant Float := Self.References.Get_Pitch;
      Yaw_Rate_Reference : constant Float := Self.References.Get_Yaw_Rate;

      ESCs_Pulse_Widths : constant Real_Vector := Self.ESCs.Get_Pulse_Widths; 
      
      Motors_Angular_Velocities : constant Real_Vector := Self.Motors.Get_Angular_Velocities;

      Multicopter_Forces_And_Moments : constant Real_Vector := Self.Motion.Get_Forces_And_Moments;
      Multicopter_Linear_And_Angular_Velocities : constant Real_Vector := Self.Motion.Get_Linear_And_Angular_Velocities;
      Multicopter_Position_And_Orientation : constant Real_Vector := Self.Motion.Get_Position_And_Orientation;

      Sensor_Roll : constant Float := Self.Absolute_Orientation_Sensor.Get_Roll;
      Sensor_Pitch : constant Float := Self.Absolute_Orientation_Sensor.Get_Pitch;
      Sensor_Yaw_Rate : constant Float := Self.Absolute_Orientation_Sensor.Get_Yaw_Rate;

   begin
      
      -- Time.
      
      Put (Self.File_Handler.all, Elapsed_Time_Float'Image); Put (Self.File_Handler.all, ",");
      
      -- References.
      
      Put (Self.File_Handler.all, Throttle_Reference'Image); Put (Self.File_Handler.all, ",");
      Put (Self.File_Handler.all, Roll_Reference'Image); Put (Self.File_Handler.all, ",");
      Put (Self.File_Handler.all, Pitch_Reference'Image); Put (Self.File_Handler.all, ",");
      Put (Self.File_Handler.all, Yaw_Rate_Reference'Image); Put (Self.File_Handler.all, ",");

      -- ESCs.

      for I in ESCs_Pulse_Widths'Range loop
      
         Put (Self.File_Handler.all, ESCs_Pulse_Widths (I)'Image); Put (Self.File_Handler.all, ",");
         
      end loop;
      
      -- Motors.
      
      for I in Motors_Angular_Velocities'Range loop
      
         Put (Self.File_Handler.all, Motors_Angular_Velocities (I)'Image); Put (Self.File_Handler.all, ",");
         
      end loop;
      
      -- Motion.
         
      for I in Multicopter_Forces_And_Moments'Range loop
            
         Put (Self.File_Handler.all, Multicopter_Forces_And_Moments (I)'Image); Put (Self.File_Handler.all, ",");
            
      end loop;
         
      for I in Multicopter_Linear_And_Angular_Velocities'Range loop
            
         Put (Self.File_Handler.all, Multicopter_Linear_And_Angular_Velocities (I)'Image); Put (Self.File_Handler.all, ",");
            
      end loop;
         
      for I in Multicopter_Position_And_Orientation'Range loop
        
         Put (Self.File_Handler.all, Multicopter_Position_And_Orientation (I)'Image); Put (Self.File_Handler.all, ",");
            
      end loop;
         
      -- Sensor.
            
      Put (Self.File_Handler.all, Sensor_Roll'Image); Put (Self.File_Handler.all, ",");
      Put (Self.File_Handler.all, Sensor_Pitch'Image); Put (Self.File_Handler.all, ",");
      Put (Self.File_Handler.all, Sensor_Yaw_Rate'Image);
      
      -- New line.
      
      New_Line (Self.File_Handler.all);

   end On_Loop;

   ------------
   -- On_End --
   ------------

   procedure On_End (Self : in out Bundle) is
   begin
      Close (Self.File_Handler.all);
   end On_End;

end Logging.Logger;
