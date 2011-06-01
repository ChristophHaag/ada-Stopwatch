--  License: WTFPL

with Ada.Real_Time;

package Stopwatch is

   procedure Start;
   procedure Stop;

   function Get_Time_Image return String;

private
   starttime, stoptime : Ada.Real_Time.Time;
   type STATES is (IDLE, STARTED, STOPPED, ERROR);
   state : STATES := IDLE;
   errmsg : access String;
end Stopwatch;
