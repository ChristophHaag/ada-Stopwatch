--  License: WTFPL

with Ada.Real_Time;

package Stopwatch is
   type STATES is (NONE, IDLE, STARTED, STOPPED, ERROR);

   procedure Start;
   procedure Stop;
   function Get_Time_Image return String;
   function Get_State return STATES;

   procedure Create_Stopwatches (count : Positive);
   function Get_Time_Image (index : Positive) return String;
   procedure Start (index : Positive);
   procedure Stop (index : Positive);
   function Get_State (index : Positive) return STATES;

private
   --  single stopwatch
   starttime, stoptime : Ada.Real_Time.Time;
   state : STATES := NONE;
   errmsg : access String;

   --  multiple stopwatches
   type StopWatchInstance is record
      state : STATES := NONE;
      starttime, stoptime : Ada.Real_Time.Time;
      errmsg : access String;
   end record;
   type StopWatchArrayType is array (Positive range <>) of StopWatchInstance;
   StopWatchArray : access StopWatchArrayType;
end Stopwatch;
