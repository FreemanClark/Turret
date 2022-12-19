README FOR LASER TURRET

Software setup:
1. Build the program using the ARM C compiler. We used Keil uVision for this.
2. Flash the program to the board. There should not be a need to reset the screen.

Hardware setup
1. Make the brace for the laser pointer to sit on top of the 28BYJ-48 motor
2. Connect the motor control board to the LPC1768 board
	a. Pin A should connect to P2.2, B to 2.3, and so on
	b. If the second motor control is functional, connect the second motor to pins 0.2, 0.3, in the same manner as above
3. Connect all boards to external power
	a. Connect a breadboard power supply with 5V out to a small breadboard
	b. Connect the (+) pins on the boards to the positive rail on the breadboard, and the GND pins to the (-) rail
	***NOTE*** the power supply will overheat after a minute of continuous operation. This is a software issue, but for the time being, turn it off when it is not being used
