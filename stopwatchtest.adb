with Ada.Text_IO, Stopwatch;
procedure StopwatchTest is

begin
   Stopwatch.Create_Stopwatches (6);

   --  will not be stopped
   Stopwatch.Start (5);

   --  has not been started
   Stopwatch.Stop (6);

   Stopwatch.Start;

   Stopwatch.Start (1);
   Stopwatch.Start (2);
   delay 0.2;
   Stopwatch.Stop (1);
   Stopwatch.Start (3);
   delay 0.4;
   Stopwatch.Stop (2);
   delay 0.3;
   Stopwatch.Stop (3);

   Stopwatch.Stop;

   --  0.2
   Ada.Text_IO.Put_Line ("1: " & String'(Stopwatch.Get_Time_Image (1)) &
      " (should be: 0.2)");

   --  0.2 + 0.4 = 0.6
   Ada.Text_IO.Put_Line ("2: " & String'(Stopwatch.Get_Time_Image (2))  &
      " (should be: 0.6)");

   --  0.4 + 0.3 = 0.7
   Ada.Text_IO.Put_Line ("3: " & String'(Stopwatch.Get_Time_Image (3)) &
      " (should be: 0.7)");

   --  0.2 + 0.4 + 0.3 = 0.9
   Ada.Text_IO.Put_Line ("all: " & Stopwatch.Get_Time_Image &
      " (should be: 0.9)");

   --  not started
   Ada.Text_IO.Put_Line ("4: " & String'(Stopwatch.Get_Time_Image (4)) &
      " (not started)");

   --  not stopped
   Ada.Text_IO.Put_Line ("5: " & String'(Stopwatch.Get_Time_Image (5)) &
      " (not stopped)");

   --  falsely stopped
   Ada.Text_IO.Put_Line ("6: " & String'(Stopwatch.Get_Time_Image (6)) &
      " (stopped, but not started)");
end StopwatchTest;
