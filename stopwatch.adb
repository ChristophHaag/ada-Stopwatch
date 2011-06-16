--  License: WTFPL

package body Stopwatch is

   procedure Start is
   begin
      starttime := Ada.Real_Time.Clock;
      if ((state = NONE) or (state = IDLE)) then
         state := STARTED;
      else
         errmsg := new String'("An error occured: Stopwatch was started " &
            "while in state: " & STATES'Image (state));
         state := ERROR;
      end if;
   end Start;

   procedure Stop is
   begin
      stoptime := Ada.Real_Time.Clock;
      if (state = STARTED) then
         state := STOPPED;
      elsif (state = ERROR) then
         return;
      else
         errmsg := new String'("An error occured: Stopwatch was stopped " &
            "while in state: " & STATES'Image (state));
         state := ERROR;
      end if;
   end Stop;

   function Get_Time_Image return String is
      timespan : Ada.Real_Time.Time_Span;
   begin
      if (state = STOPPED) then
         timespan := Ada.Real_Time."-" (stoptime, starttime);
         state := IDLE;
         return (Duration'Image (Ada.Real_Time.To_Duration (timespan)) &
            " seconds");
      elsif (state = ERROR) then
         return errmsg.all;
      else
         errmsg := new String'("An error occured: Time read while in state " &
            STATES'Image (state));
         return errmsg.all;
      end if;
   end Get_Time_Image;

   function Get_State return STATES is
   begin
      return state;
   end Get_State;



   procedure Create_Stopwatches (count : Positive) is
   begin
      StopWatchArray := new StopWatchArrayType (1 .. count);
   end Create_Stopwatches;

   procedure Start (index : Positive) is
   begin
      StopWatchArray (index).starttime := Ada.Real_Time.Clock;
      if ((StopWatchArray (index).state = IDLE) or
            (StopWatchArray (index).state = NONE))
      then
         StopWatchArray (index).state := STARTED;
      else
         StopWatchArray (index).errmsg := new String'("An error occured: " &
            "Stopwatch was started while in state: " &
            STATES'Image (StopWatchArray (index).state));
         StopWatchArray (index).state := ERROR;
      end if;
   end Start;

   procedure Stop (index : Positive) is
   begin
      StopWatchArray (index).stoptime := Ada.Real_Time.Clock;
      if (StopWatchArray (index).state = STARTED) then
         StopWatchArray (index).state := STOPPED;
      elsif (StopWatchArray (index).state = ERROR) then
         return;
      else
         StopWatchArray (index).errmsg := new String'("An error occured: " &
            "Stopwatch was stopped while in state: " &
            STATES'Image (StopWatchArray (index).state));
         StopWatchArray (index).state := ERROR;
      end if;
   end Stop;

   function Get_Time_Image (index : Positive) return String is
      timespan : Ada.Real_Time.Time_Span;
   begin
      if (StopWatchArray (index).state = STOPPED) then
         timespan := Ada.Real_Time."-"
            (StopWatchArray (index).stoptime,
             StopWatchArray (index).starttime);
         StopWatchArray (index).state := IDLE;
         return (Duration'Image (Ada.Real_Time.To_Duration (timespan)) &
            " seconds");
      elsif (StopWatchArray (index).state = ERROR) then
         return StopWatchArray (index).errmsg.all;
      else
         StopWatchArray (index).errmsg := new String'("An error occured: " &
            "Time read while in state: " &
            STATES'Image (StopWatchArray (index).state));
         return StopWatchArray (index).errmsg.all;
      end if;
   end Get_Time_Image;

   function Get_State (index : Positive) return STATES is
   begin
      return StopWatchArray (index).state;
   end Get_State;
end Stopwatch;
