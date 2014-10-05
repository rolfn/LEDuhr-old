
#ifndef KEYSCAN_H
#define KEYSCAN_H  1

#include <util/atomic.h>
#include <avr/io.h>

#ifndef KEY_PIN
#define KEY_PIN     PINB
#endif

#ifndef REPEAT_MASK
#define REPEAT_MASK     0
#endif

#ifndef KEYSCAN_PERIOD
#define KEYSCAN_PERIOD  10e-3
#endif

#define REPEAT_START    0.5 / KEYSCAN_PERIOD  //  20 if 10ms
#define REPEAT_NEXT     0.2 / KEYSCAN_PERIOD  //  50 if 10ms
#define VERY_LONG_CNTS  1.0 / KEYSCAN_PERIOD  // 100 if 10ms

#define NO_KEY 0
#define SHORT_KEY 1
#define LONG_KEY 2
#define VERYLONG_KEY 4
#define IMPROPER_KEY 8

extern void keyscan(void);
extern uint8_t get_key_press( uint8_t key_mask );
extern uint8_t get_key_rpt( uint8_t key_mask );
extern uint8_t get_key_short( uint8_t key_mask );
extern uint8_t get_key_long( uint8_t key_mask );
extern uint8_t get_key_long_r( uint8_t key_mask );
extern uint8_t get_key_rpt_l( uint8_t key_mask );
extern void getKey(uint8_t key_mask);

extern uint8_t key;

#endif // KEYSCAN_H
