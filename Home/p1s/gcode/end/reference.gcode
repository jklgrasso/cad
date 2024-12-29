M400 ; wait for buffer to clear - Wait for the motion buffer to clear before proceeding.
G92 E0 ; zero the extruder - Set the current position of the extruder to 0.
G1 E-0.8 F1800 ; retract - Retract the filament by -0.8 mm at a feed rate of 1800 mm/min.
G1 Z{max_layer_z + 0.5} F900 ; lower z a little - Move the Z-axis down by (max_layer_z + 0.5) units at a feed rate of 900 mm/min.
G1 X65 Y245 F12000 ; move to safe pos - Move the print head to X=65, Y=245 at a rapid feed rate of 12000 mm/min.
G1 Y265 F3000 - Move the print head to Y=265 at a feed rate of 3000 mm/min.

G1 X65 Y245 F12000 - Move the print head back to X=65, Y=245 at a rapid feed rate of 12000 mm/min.
G1 Y265 F3000 - Move the print head back to Y=265 at a feed rate of 3000 mm/min.
M140 S0 ; turn off bed - Turn off the heated bed.
M106 S0 ; turn off fan - Turn off the print cooling fan.
M106 P2 S0 ; turn off remote part cooling fan - Turn off an additional cooling fan.
M106 P3 S0 ; turn off chamber cooling fan - Turn off the chamber cooling fan.

G1 X100 F12000 ; wipe - Perform a wiping motion at X=100 at a rapid feed rate of 12000 mm/min.
; pull back filament to AMS
M620 S255 - Control an external mechanism (AMS) to pull back the filament at full power.
G1 X20 Y50 F12000 - Move to X=20, Y=50 at a rapid feed rate of 12000 mm/min.
G1 Y-3 - Move to Y=-3.
T255 - Select tool (extruder) number 255.
G1 X65 F12000 - Move to X=65 at a rapid feed rate of 12000 mm/min.
G1 Y265 - Move to Y=265.
G1 X100 F12000 ; wipe - Perform another wiping motion at X=100 at a rapid feed rate of 12000 mm/min.
M621 S255 - Control an external mechanism (AMS) for filament handling.
M104 S0 ; turn off hotend - Turn off the hotend (extruder).

M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1 - Conditional branching based on the status of the timelapse_record_flag.
    M400 ; wait all motion done - Wait for all motion to complete.
    M991 S0 P-1 ; end smooth timelapse at safe pos - End smooth timelapse at a safe position.
    M400 S3 ; wait for last picture to be taken - Wait for the last picture to be taken.
M623; end of "timelapse_record_flag" - End of the timelapse recording flag section.

M400 ; wait all motion done - Wait for all motion to complete.
M17 S - Enable stepper motors.
M17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom - Lower the motor current for the Z-axis to reduce the impact if there's something at the bottom.
{if (max_layer_z + 100.0) < 250}
    G1 Z{max_layer_z + 100.0} F600 - Move the Z-axis to (max_layer_z + 100.0) at a feed rate of 600 mm/min if the condition is met.
    G1 Z{max_layer_z +98.0} - Move the Z-axis to (max_layer_z + 98.0).
{else}
    G1 Z250 F600 - Move the Z-axis to 250 at a feed rate of 600 mm/min if the condition is not met.
    G1 Z248 - Move the Z-axis to 248.
{endif}
M400 P100 - Wait for 100 milliseconds.
M17 R ; restore z current - Restore the Z-axis motor current.

G90 - Set to absolute positioning mode.
G1 X128 Y250 F3600 - Move to X=128, Y=250 at a feed rate of 3600 mm/min.

M220 S100  ; Reset feedrate magnitude - Reset the feedrate magnitude to 100%.
M201.2 K1.0 ; Reset acc magnitude - Reset the acceleration magnitude to 1.0.
M73.2   R1.0 ; Reset left time magnitude - Reset the left time magnitude to 1.0.
M1002 set_gcode_claim_speed_level : 0 - Set the G-code claim speed level to 0.

M17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power - Lower the motor currents to 45% power for X, Y, and Z axes.
