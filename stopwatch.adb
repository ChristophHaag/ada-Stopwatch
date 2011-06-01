--  License: WTFPL

package body Stopwatch is

   procedure Start is
   begin
      starttime := Ada.Real_Time.Clock;
      if (state = IDLE) then
         state := STARTED;
      else
         state := ERROR;
         errmsg := new String'("An error occured: Stopwatch was started " &
            "while in state: " & STATES'Image (state));
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
         state := ERROR;
         errmsg := new String'("An error occured: Stopwatch was stopped " &
            "while in state: " & STATES'Image (state));
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
         errmsg := new String'("An error occured: Stopwatch was stopped " &
            "while in state: " & STATES'Image (state));
         return errmsg.all;
      end if;
   end Get_Time_Image;

end Stopwatch;
