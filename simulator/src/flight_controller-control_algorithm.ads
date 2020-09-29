package Flight_Controller.Control_Algorithm is

   type Bundle (Roll_PID : PID_Controllers.Parallel_PID_Controller_Access;
                Pitch_PID : PID_Controllers.Parallel_PID_Controller_Access;
                Yaw_Rate_PID : PID_Controllers.Parallel_PID_Controller_Access;
                Quadcopter_Cross_Mixer : Mixers.Quadcopter_Cross_Mixer_Access;
                References : Any_References_Reader;
                ESCs : Actuators.Any_ESCs_Writer;
                Absolute_Orientation_Sensor : Sensors.Any_Absolute_Orientation_Sensor_Reader) is

     new Cyclics.Bundle with null record;

   procedure On_Start (Self : in out Bundle);

   procedure On_Loop (Self : in out Bundle; Elapsed_Time : Time_Span);

   procedure On_End (Self : in out Bundle);

end Flight_Controller.Control_Algorithm;
