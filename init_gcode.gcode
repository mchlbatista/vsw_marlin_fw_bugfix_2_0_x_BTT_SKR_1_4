; Initial gcode for SuperSlicer

M117 Heating... ;Put printing message on LCD screen
M300 S2500 P100; Beep

M104 S180; Set initial Extruder temp
M140 S[first_layer_bed_temperature] ; set bed temp
M190 S[first_layer_bed_temperature] ; wait for bed temp
M109 S180; Wait for initial extruder temp

G28
G29

G90 ; use absolute coordinates
M83 ; extruder relative mode
G1 X82.5 Y-3 F8000 ; Move to a position in the left front of the bed
G1 Z0.6; Move nozzle above 0.6 mm of the bed
G91 ; Use relative mode

M104 S{first_layer_temperature[initial_extruder]+extruder_temperature_offset[initial_extruder]} ; set extruder temp
M109 S{first_layer_temperature[initial_extruder]+extruder_temperature_offset[initial_extruder]} ; wait for extruder temp


; now print a line of filament to prepare extrusion
G92 E0.0
G1 F1800 E3
G1 X40 E20 F1000 ; prints a line in the front
G1 X40 E20 F800 ; prints a line in the front
G92 E0.0
M221 S{if layer_height<0.075}100{else}95{endif}

; Don't change E values below. Excessive value can damage the printer.
{if print_settings_id=~/.*(DETAIL @VSW|QUALITY @VSW).*/}M907 E400 ; set extruder motor current{endif}
{if print_settings_id=~/.*(SPEED @VSW|DRAFT @VSW).*/}M907 E500 ; set extruder motor current{endif}
