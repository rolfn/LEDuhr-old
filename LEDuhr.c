#include <stdlib.h>
#include <util/delay.h>
#include <avr/interrupt.h>
#include <avr/io.h>
#include "dcf77/dcf77.h"
#include "i2c/i2cmaster.h"
#include "i2clcd.h"
#include "i2cled.h"

#include "RN-utils.h"

#define DEBUG
#define SHOW_SECONDS

#define BCD_EN_DDR   DDRD
#define BCD_EN_PORT  PORTD
#define BCD_EN_MIN_1    PD4
#define BCD_EN_MIN_10   PD5
#define BCD_EN_HOUR_1   PD6
#define BCD_EN_HOUR_10  PD7

#define BCD_DDR      DDRC
#define BCD_PORT     PORTC
#define BCD_IN_PORT  PINC
#define BCD_PIN1     PC0
#define BCD_PIN2     PC1
#define BCD_PIN3     PC2
#define BCD_PIN4     PC3

typedef struct {
  uint8_t minute;
  uint8_t hour;
} wakeup_time;

wakeup_time wakeupTime;

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

  sei();

  //??//PORTD = 0xFF; // enable pull ups
  //DDRD |= 1<<PD3;

  timebase_init();
  sei();

  for(;;) {

    //if( DCF77_PIN & 1<<DCF77 ) PORTD |= 1<< PD3;
    //else PORTD &= ~(1<<PD3);
    _delay_us(1); // ???

    if( timeflags & 1<<ONE_SECOND ) {
      timeflags = 0;
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

      getWakeupTime();
      printDEC(2, 1, wakeupTime.hour);
      lcd_printlc(2, 4, ":");
      printDEC(2, 5, wakeupTime.minute);

      if ( synchronize == 0xFF ) {

        //

      }
    }
  }
}
