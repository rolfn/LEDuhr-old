#ifndef RN_UTILS_H
#define RN_UTILS_H  1

#include "i2clcd.h"

// http://www.mikrocontroller.net/topic/67405#541927
extern void outDEC(uint8_t val, char *outp);
extern void outHEX(uint8_t val, char *outp);

extern void printHEX(uint8_t l, uint8_t c, uint8_t val);
extern void printDEC(uint8_t l, uint8_t c, uint8_t val);

#define ClearBit(x,y) x &= ~_BV(y)      //   equivalent to   cbi(x,y)
#define SetBit(x,y) x |= _BV(y)         //   equivalent to   sbi(x,y)

#endif // RN_UTILS_H
