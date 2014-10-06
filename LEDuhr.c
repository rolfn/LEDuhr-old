#include <stdlib.h>
#include <util/delay.h>
#include <avr/interrupt.h>
#include <avr/io.h>
#include "dcf77/dcf77.h"
#include "i2c/i2cmaster.h"
#include "i2clcd/i2clcd.h"
#include "i2cled/i2cled.h"

#include "keyscan/keyscan.h"

#include "LEDuhr.h"

#include "RN-utils.h"

#define DEBUG

wakeup_time wakeupTime;
uint8_t modeFlag = 0;

#define  SHOW_SECONDS 0

void getWakeupTime(void) {
  uint8_t val = 0, tmp;
  // 1. BCD-Schalter (Minuten-Einer) auswählen.
  BCD_EN_PORT = ~_BV(BCD_EN_MIN_1) & (_BV(BCD_EN_MIN_10) | _BV(BCD_EN_HOUR_1) |
    _BV(BCD_EN_HOUR_10));
  do { // Solange Port einlesen bis Wert stabil ist.
    tmp = val;
    val = BCD_IN_PORT;
  } while (val != tmp);
  val = ~BCD_IN_PORT & 0x0F;
  wakeupTime.minute = val;
  // 2. BCD-Schalter (Minuten-Zehner) auswählen.
  BCD_EN_PORT = ~_BV(BCD_EN_MIN_10) & (_BV(BCD_EN_MIN_1) | _BV(BCD_EN_HOUR_1) |
    _BV(BCD_EN_HOUR_10));
  do { // Solange Port einlesen bis Wert stabil ist.
    tmp = val;
    val = BCD_IN_PORT;
  } while (val != tmp);
  val = ~BCD_IN_PORT & 0x0F;
  wakeupTime.minute += val * 10;
  // 3. BCD-Schalter (Stunden-Einer) auswählen.
  BCD_EN_PORT = ~_BV(BCD_EN_HOUR_1) & (_BV(BCD_EN_MIN_1) | _BV(BCD_EN_MIN_10) |
    _BV(BCD_EN_HOUR_10));
  do { // Solange Port einlesen bis Wert stabil ist.
    tmp = val;
    val = BCD_IN_PORT;
  } while (val != tmp);
  wakeupTime.hour = ~BCD_IN_PORT & 0x0F;
  // 4. BCD-Schalter (Stunden-Zehner) auswählen.
  BCD_EN_PORT = ~_BV(BCD_EN_HOUR_10) & (_BV(BCD_EN_MIN_1) | _BV(BCD_EN_MIN_10) |
    _BV(BCD_EN_HOUR_1));
  do { // Solange Port einlesen bis Wert stabil ist.
    tmp = val;
    val = BCD_IN_PORT;
  } while (val != tmp);
  val = ~BCD_IN_PORT & 0x0F;
  wakeupTime.hour += val * 10;
}

char *getDigits(uint8_t nb) {
  static char buf[] = "  \x0";
  buf[1] = (nb % 10) + '0';
  buf[0] = (nb / 10) + '0';
  return buf;
}

uint8_t tickCnt = 0, bar = 0;
uint16_t s_good, s_bad;
uint32_t quality;

int main(void) {

  i2c_init();
  SS_Init(LED_DISP_1);                  //   initialize HT16K33 LED controller
  SS_Init(LED_DISP_2);                  //   initialize HT16K33 LED controller
  SS_SetBrightness(LED_DISP_1, 4);
  SS_SetBrightness(LED_DISP_2, 0);
  SS_SetColon(LED_DISP_1, 1);
  SS_SetColon(LED_DISP_2, 0);

  //timebase_init();

  // Ausgänge festlegen
  BCD_EN_DDR |= _BV(BCD_EN_MIN_1) | _BV(BCD_EN_MIN_10) | _BV(BCD_EN_HOUR_1) | _BV(BCD_EN_HOUR_10);

  // Eingänge festlegen
  BCD_DDR &= ~(_BV(BCD_PIN1) | _BV(BCD_PIN2) | _BV(BCD_PIN3) | _BV(BCD_PIN4));
  // Pullup-Widerstände aktivieren
  BCD_PORT  |= _BV(BCD_PIN1) | _BV(BCD_PIN2) | _BV(BCD_PIN3) | _BV(BCD_PIN4);

#ifdef DEBUG
  lcd_init();
  // always set all three parameters  (ON/OFF) when using this command
  lcd_command(LCD_DISPLAYON | LCD_CURSOROFF | LCD_BLINKINGOFF);
  lcd_light(true);
  lcd_printlc(1, 1, "DCF77");
#endif

  timebase_init();
  KEY_PORT |= 1<<THEKEY;                                  // Pullup on
  sei();

  for(;;) {

    _delay_us(1);

    if( timeflags & 1<<ONE_TICK ) { // Call every 1s/64 = 15.625ms
      timeflags &= ~(1<<ONE_TICK);
      keyscan();
      getKey(1<<THEKEY);
#ifdef DEBUG
      /*
      if (tickCnt & 0x80) { // 128 * 15.625ms = 2000ms
        tickCnt = 0;
        lcd_printlc(1, 10, " ");
      }
      tickCnt += 1;
      */
      if ( (key==SHORT_KEY) || (key==LONG_KEY) || (key==VERYLONG_KEY) ) {
        switch (key) {
          case SHORT_KEY:
            lcd_printlc(1, 10, "S");
            break;
          case LONG_KEY:
            lcd_printlc(1, 10, "L");
            modeFlag ^= (1<<SHOW_SECONDS); // toggle between date and seconds
            break;
          case VERYLONG_KEY:
            lcd_printlc(1, 10, "V");
            break;
        }
        key = NO_KEY;
        _delay_ms(2000);
        lcd_printlc(1, 10, " ");
      }
#endif
    }

    if( timeflags & 1<<ONE_SECOND ) {
      //printHEX(2, 16, timeflags);
      //timeflags = 0;
      timeflags &= ~(1<<ONE_SECOND);

      clock();

#ifdef DEBUG
      printHEX(1, 19, dcf77error);
      lcd_printlc(4, 1, getDigits(time.hour));
      lcd_printlc(4, 3, ":");
      lcd_printlc(4, 4, getDigits(time.minute));
      lcd_printlc(4, 6, ":");
      lcd_printlc(4, 7, getDigits(time.second));

      lcd_printlc(4, 10, getDigits(time.day));
      lcd_printlc(4, 12, ".");
      lcd_printlc(4, 13, getDigits(time.month));
      lcd_printlc(4, 15, ".");
      lcd_printlc(4, 16, "2");
      lcd_printlc(4, 17, "0");
      lcd_printlc(4, 18, getDigits(time.year));
#endif
      // first LED display: time
      SS_SetDigit(LED_DISP_1, 0, time.hour / 10);
      SS_SetDigit(LED_DISP_1, 1, time.hour % 10);
      SS_SetDigit(LED_DISP_1, 2, time.minute / 10);
      SS_SetDigit(LED_DISP_1, 3, time.minute % 10);
      // second LED display: date or secondsS
      if ( modeFlag & 1<<SHOW_SECONDS ) {
        SS_BlankDigit(LED_DISP_2, 0);
        SS_BlankDigit(LED_DISP_2, 1);
        SS_SetDigit(LED_DISP_2, 2, time.second / 10);
        SS_SetDigit(LED_DISP_2, 3, time.second % 10);
      } else {
        SS_SetDigit(LED_DISP_2, 0, time.day / 10);
        SS_SetDigit(LED_DISP_2, 1, time.day % 10 | SET_DP);
        SS_SetDigit(LED_DISP_2, 2, time.month / 10);
        SS_SetDigit(LED_DISP_2, 3, time.month % 10);
      }
#ifdef DEBUG
      if(time.second == 1) {// some statistics
        if ( dcf77error == 0 ) s_good++;
        else s_bad++;
        quality = ((uint32_t)s_good * (uint32_t)1000) / (uint32_t)(s_good+s_bad);
        printDEC_L(2, 10, s_good);
        printDEC_L(2, 16, s_bad);
        printDEC_L(1, 12, (uint16_t)quality);
      }
#endif
      getWakeupTime();
      printDEC(2, 1, wakeupTime.hour);
      lcd_printlc(2, 4, ":");
      printDEC(2, 5, wakeupTime.minute);

    }
  }
}
