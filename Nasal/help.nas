var help_win = screen.window.new( 0, 0, 1, 3 );
help_win.fg = [0,1,1,1];

# Target Roll
var target_roll = func {
   var target_roll_deg = getprop("autopilot/internal/target-roll-deg");
   if(  target_roll_deg == nil ) target_roll_deg = 0.0;
   help_win.write(sprintf("Target Roll: %.0f degrees", target_roll_deg) );
}
 setlistener( "autopilot/internal/target-roll-deg", target_roll, 0, 0 );

var messenger = func{
help_win.write(arg[0]);
}
print("Help subsystem started");
