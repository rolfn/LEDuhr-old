
#include <stdint.h>
#include <avr/pgmspace.h>
#include "i2clcd.h"

const unsigned char HEX[] PROGMEM = {"0123456789ABCDEF"};

void outHEX(uint8_t val, char *outp) {
  outp[2] = '\0';
  outp[1] = pgm_read_byte(&HEX[val & 0x0F]);
  outp[0] = pgm_read_byte(&HEX[val >> 4]);
}

// http://www.mikrocontroller.net/topic/67405#541927
void outDEC(uint8_t val, char *outp) {
  int8_t i = 3;
  uint8_t v = val;
  outp[i] = '\0';
  while(--i >= 0) {
     outp[i] = '0' + v % 10;
     v /= 10;
  }
}

void outDEC_L(uint16_t val, char *outp) {
  int8_t i = 5;
  uint16_t v = val;
  outp[i] = '\0';
  while(--i >= 0) {
     outp[i] = '0' + v % 10;
     v /= 10;
  }
}

char buf[8];

void printHEX(uint8_t l, uint8_t c, uint8_t val) {
  outHEX(val, buf);
  lcd_printlc(l, c, buf);
}
void printDEC(uint8_t l, uint8_t c, uint8_t val) {
  outDEC(val, buf);
  lcd_printlc(l, c, buf);
}

void printDEC_L(uint8_t l, uint8_t c, uint16_t val) {
  outDEC_L(val, buf);
  lcd_printlc(l, c, buf);
}


