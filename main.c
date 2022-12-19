/*-----------------------------------------------------------------------------
 * Name:    main.c
 * Purpose: test LCD on MCB1700 board
 * Note(s):
 *					- screen resolution = 240x320
 *-----------------------------------------------------------------------------
 * Based on Keil Demo project
 *----------------------------------------------------------------------------*/

#include "Board_GLCD.h"
#include "GLCD_Config.h"
#include "string.h"
#include "stdio.h"
#include "stdlib.h"

extern GLCD_FONT GLCD_Font_6x8;				// character resolution
extern GLCD_FONT GLCD_Font_16x24;			// character resolution

char* int_to_3char(int);
char* stringmaker(int, int);
// if time permits, make another font for height and elevation
// outputs
//GLCD_FONT GLCD_Font_16x24 = {
//  16,                                   ///< Character width
//  24,                                   ///< Character height
//  32,                                   ///< Character offset
//  112,                                  ///< Character count
//  Font_16x24_h                          ///< Characters bitmaps
//};

int bearing = 0, elevation = 0; //bearing and elevation
extern void motorstart(void);
/*-----------------------------------------------------------------------------
  Main function
 *----------------------------------------------------------------------------*/
int main (void) {
  char text_string[14] = "  000     000";
	motorsetup();
	
	GLCD_Initialize         ();           /* Initialize Graphical LCD           */
	GLCD_ClearScreen        ();           /* Clear Graphical LCD                */
  
	/* Test some of the functions shown in the Board_GLCD.h */
  GLCD_SetBackgroundColor (GLCD_COLOR_BLUE);
  GLCD_SetForegroundColor (GLCD_COLOR_WHITE);
  GLCD_SetFont            (&GLCD_Font_16x24);
  GLCD_DrawString         (0, 0*24, "     Aim Control    "); //title the screen
	
  GLCD_SetBackgroundColor (GLCD_COLOR_WHITE);
  GLCD_SetForegroundColor (GLCD_COLOR_BLUE);
	GLCD_SetFont            (&GLCD_Font_16x24); //set font for output strings
	GLCD_DrawString         (40, 3*24, "  BRNG    ELEV    ");
  //GLCD_DrawString         (100, 11*8, "      Example       ");
	GLCD_DrawString         (40, 4*24, text_string);				
//	GLCD_DrawRectangle      (5, 60, 5, 5);
//	GLCD_DrawBargraph				(5, 70, 150, 5, 100);
	
	GLCD_SetForegroundColor (GLCD_COLOR_RED);
//	GLCD_DrawRectangle      (5, 50, 5, 5);
//	GLCD_DrawBargraph				(5, 80, 50, 5, 10);
//	GLCD_DrawBargraph				(5, 90, 50, 5, 50);
//	GLCD_DrawBargraph				(5, 100, 50, 5, 80);
//	GLCD_DrawBargraph				(5, 110, 50, 5, 100);
 
	int prev_brng = bearing;
	int prev_elev = elevation;
  while (1) {				
		/* Main loop         */
		update_motor();
		//set string to position, update screen
		if(bearing != prev_brng || elevation != prev_elev) { //update brng and elevation
			char* d_text = stringmaker(bearing, elevation);
			int i; //this is GAY AS FUCK HOLY SHIT
			for(i = 0; i < 14; i++) {
				text_string[i] = d_text[i];
			}
			GLCD_DrawString(40, 4*24, text_string);
		}
  }
}

char* stringmaker(int brng, int elev) {
	char* brng_3char = int_to_3char(brng);
	char* elev_3char = int_to_3char(elev);
	char* prec_space = "  ";
	char* inter_space = "     ";
	char* front = strcat(prec_space, brng_3char);
	char* back = strcat(inter_space, elev_3char);
	return strcat(front, back);
}

char* int_to_3char(int to_conv) {
	char c1, c2, c3;
	int i_c1 = to_conv / 100;
	c1 = i_c1 + 48;
	to_conv -= 100 * i_c1;
	int i_c2 = to_conv / 10;
	c2 = i_c2 + 48;
	to_conv -= 10 * i_c1;
	int i_c3 = to_conv;
	c3 = i_c3 + 48;
	char* numarr = (char*)malloc((3)*sizeof(char));
	return numarr;
}