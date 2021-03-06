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
uint8_t modeflag = 0;
uint8_t beforeFirstSync = 1;

void checkAlarm(void) {
  if ((modeflag & 1<<WAKEUP) && (wakeupTime.minute == time.minute) &&
    (wakeupTime.hour == time.hour)) modeflag |= (1<<ALARM); // alarm on
  else modeflag &= ~(1<<ALARM);                             // alarm off
}

void increaseWakeupTime(void) {
  wakeupTime.minute += SNOOZE_MINUTES;
  if (wakeupTime.minute > 59) {
    wakeupTime.minute -= 60;
    wakeupTime.hour += 1;
    if (wakeupTime.hour > 23) {
      wakeupTime.hour -= 24;
    }
  }
  // // //
  printDEC(3, 13, wakeupTime.hour);
  lcd_printlc(3, 16, ":");
  printDEC(3, 17, wakeupTime.minute);
}

void getWakeupTime(void) {
  if (modeflag & 1<<SNOOZE) return; // in snooze mode no update
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
        if ((modeflag & 1<<ALARM) || (modeflag & 1<<SNOOZE)) {
          switch (key) {
            case SHORT_KEY: // snooze on, alarm off, alarmtime += 5min
              // TODO: Ist SNOOZE-Bit überhaupt nötig?
              if (!(modeflag & 1<<SNOOZE)) modeflag |= (1 << SNOOZE);
              if ((modeflag & 1<<SNOOZE) && (modeflag & 1<<ALARM)) {
                increaseWakeupTime();
              }
              break;
            case LONG_KEY: // alarm off, snooze off
              modeflag &= ~((1 << ALARM) | (1 << SNOOZE));
              // now alarmtime again from BCD switches
              break;
            case VERYLONG_KEY:
              //
              break;
          }
        } else {
          switch (key) {
            case SHORT_KEY:
              lcd_printlc(1, 14, "S");
              modeflag ^= (1<<WAKEUP); // toggle wakeup on/off
              // show active wakeup ...
              break;
            case LONG_KEY:
              lcd_printlc(1, 14, "L");
              SS_SetDigitRaw(LED_DISP_2, 0, 0);
              SS_SetDigitRaw(LED_DISP_2, 1, 0);
              SS_SetDigitRaw(LED_DISP_2, 2, 0);
              SS_SetDigitRaw(LED_DISP_2, 3, 0);
              modeflag ^= (1<<SHOW_SECONDS); // toggle between date and seconds
              break;
            case VERYLONG_KEY:
              lcd_printlc(1, 14, "V");
              break;
          }
        }
        key = NO_KEY;
        _delay_ms(400);
        lcd_printlc(1, 14, " ");
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
      printHEX(1, 16, dcf77error);
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
      if ( modeflag & 1<<SHOW_SECONDS ) {
        SS_BlankDigit(LED_DISP_2, 0);
        SS_BlankDigit(LED_DISP_2, 1);
        SS_SetDigit(LED_DISP_2, 2, time.second / 10);
        SS_SetDigit(LED_DISP_2, 3, time.second % 10);
      } else {
        SS_SetDigit(LED_DISP_2, 0, time.day / 10);
        SS_SetDigit(LED_DISP_2, 1, time.day % 10 | SET_DP);
        SS_SetDigit(LED_DISP_2, 2, time.month / 10);
        SS_SetDigit(LED_DISP_2, 3, time.month % 10 | SET_DP);
      }

      if(time.second == 1) {// some statistics
#ifdef DEBUG
        /*
        if ( dcf77error == 0 ) s_good++;
        else s_bad++;
        */
        if ( synchronize == 0xff ) beforeFirstSync = 0;

        if (!beforeFirstSync) {
          if ( synchronize == 0xff ) {
            s_good++;
          } else {
            s_bad++;
          }
          quality = ((uint32_t)s_good * (uint32_t)1000) / (uint32_t)(s_good+s_bad);
          printDEC_L(2, 10, s_good);
          printDEC_L(2, 16, s_bad);
          printDEC_L(1, 8, (uint16_t)quality);
        }
        synchronize = 0;
#endif
        getWakeupTime(); // evtl. Beides vereinigen
        checkAlarm();
      }


#ifdef DEBUG
      printDEC(2, 1, wakeupTime.hour);
      lcd_printlc(2, 4, ":");
      printDEC(2, 5, wakeupTime.minute);
      lcd_printlc(4, 15, ".");
      lcd_printlc(3, 1, "W=");
      lcd_printlc(3, 3, (modeflag & 1<<WAKEUP) ? "1" : "0");
      lcd_printlc(3, 5, "A=");
      lcd_printlc(3, 7, (modeflag & 1<<ALARM) ? "1" : "0");
      lcd_printlc(3, 9, "S=");
      lcd_printlc(3, 11, (modeflag & 1<<SNOOZE) ? "1" : "0");
#endif
    }
  }
}
