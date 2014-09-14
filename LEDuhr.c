#include <stdlib.h>
#include <util/delay.h>
#include <avr/interrupt.h>
#include <avr/io.h>
#include "dcf77/dcf77.h"
#include "i2clcd.h"
#include "i2c/i2cmaster.h"
#include "i2cled.h"

#include "RN-utils.h"

// i2c adresses
#define LCD_I2C_DEVICE (0x3F << 1)
#define LED_DISP_1     (0x70 << 1)
#define LED_DISP_2     (0x71 << 1)

#define DEBUG
#define SHOW_SECONDS

char *getDigits(uint8_t nb) {
  static char buf[] = "  \x0";
  buf[1] = (nb % 10) + '0';
  buf[0] = (nb / 10) + '0';
  return buf;
}

int main(void) {

  i2c_init();
  SS_Init(LED_DISP_1);                  //   initialize HT16K33 LED controller
  SS_Init(LED_DISP_2);                  //   initialize HT16K33 LED controller
  SS_SetBrightness(LED_DISP_1, 4);
  SS_SetBrightness(LED_DISP_2, 0);
#ifdef SHOW_SECONDS
  SS_BlankDigit(LED_DISP_2, 0);
  SS_BlankDigit(LED_DISP_2, 1);
#endif
  SS_SetColon(LED_DISP_1, 1);
  SS_SetColon(LED_DISP_2, 0);

  timebase_init();

#ifdef DEBUG
  lcd_init();
  // always set all three parameters  (ON/OFF) when using this command
  lcd_command(LCD_DISPLAYON | LCD_CURSOROFF | LCD_BLINKINGOFF);
  lcd_light(true);
  lcd_printlc(1, 1, "DCF77");
#endif

  sei();

  PORTD = 0xFF;		// enable pull ups
  DDRD |= 1<<PD3;

  timebase_init();
  sei();

  for(;;){

    if( DCF77_PIN & 1<<DCF77 ) PORTD |= 1<< PD3;
    else PORTD &= ~(1<<PD3);

    if( timeflags & 1<<ONE_SECOND ) {
      timeflags = 0;
      clock();

      printHEX(4, 19, dcf77error);
#ifdef DEBUG
      lcd_printlc(4, 1, getDigits(time.hour));
      lcd_printlc(4, 3, ":");
      lcd_printlc(4, 4, getDigits(time.minute));
      lcd_printlc(4, 6, ":");
      lcd_printlc(4, 7, getDigits(time.second));

      lcd_printlc(4, 10, getDigits(time.day));
      lcd_printlc(4, 12, ".");
      lcd_printlc(4, 13, getDigits(time.month));
      lcd_printlc(4, 15, ".");
      lcd_printlc(4, 16, getDigits(time.year));
#endif
      // first LED display: time
      SS_SetDigit(LED_DISP_1, 0, time.hour / 10);
      SS_SetDigit(LED_DISP_1, 1, time.hour % 10);
      SS_SetDigit(LED_DISP_1, 2, time.minute / 10);
      SS_SetDigit(LED_DISP_1, 3, time.minute % 10);
      // second LED display: date or seconds
#ifdef SHOW_SECONDS
      SS_SetDigit(LED_DISP_2, 2, time.second / 10);
      SS_SetDigit(LED_DISP_2, 3, time.second % 10);
#else
      SS_SetDigit(LED_DISP_2, 0, time.day / 10);
      SS_SetDigit(LED_DISP_2, 1, time.day % 10 | SET_DP);
      SS_SetDigit(LED_DISP_2, 2, time.month / 10);
      SS_SetDigit(LED_DISP_2, 3, time.month % 10);
#endif
      if ( synchronize == 0xFF ) {

        //

      }
    }
  }
}
