
/*
    Based on "Universelle Tastenabfrage" from Peter Dannegger
    see http://www.mikrocontroller.net/topic/48465

    Rolf Niepraschk, Rolf.Niepraschk@gmx.de
*/

#include "keyscan/keyscan.h"

volatile uint8_t longKeyCnt = 0;
uint8_t key = NO_KEY;

uint8_t key_state;                      // debounced and inverted key state:
                                                // bit = 1: key pressed
uint8_t key_press;                      // key press detect
uint8_t key_rpt;                        // key long press and repeat

void keyscan(void) { // call every ~10ms
  static uint8_t ct0 = 0xFF, ct1 = 0xFF, rpt;
  uint8_t i;

  i = key_state ^ ~KEY_PIN;                     // key changed ?
  ct0 = ~( ct0 & i );                           // reset or count ct0
  ct1 = ct0 ^ (ct1 & i);                        // reset or count ct1
  i &= ct0 & ct1;                               // count until roll over ?
  key_state ^= i;                               // then toggle debounced state
  key_press |= key_state & i;                   // 0->1: key press detect

  if( (key_state & REPEAT_MASK) == 0 )          // check repeat function
     rpt = REPEAT_START;                        // start delay
  if( --rpt == 0 ){
    rpt = REPEAT_NEXT;                          // repeat delay
    key_rpt |= key_state & REPEAT_MASK;
  }
  if (key_state) longKeyCnt++;

}

///////////////////////////////////////////////////////////////////
//
// check if a key has been pressed. Each pressed key is reported
// only once
//
uint8_t get_key_press( uint8_t key_mask )  // egal wie lange
{
  ATOMIC_BLOCK(ATOMIC_FORCEON){
    key_mask &= key_press;                      // read key(s)
    key_press ^= key_mask;                      // clear key(s)
  }
  return key_mask;
}

///////////////////////////////////////////////////////////////////
//
// check if a key has been pressed long enough such that the
// key repeat functionality kicks in. After a small setup delay
// the key is reported being pressed in subsequent calls
// to this function. This simulates the user repeatedly
// pressing and releasing the key.
//
uint8_t get_key_rpt( uint8_t key_mask )
{
  ATOMIC_BLOCK(ATOMIC_FORCEON){
    key_mask &= key_rpt;                        // read key(s)
    key_rpt ^= key_mask;                        // clear key(s)
  }
  return key_mask;
}

uint8_t get_key_short( uint8_t key_mask ) {
// true, wenn Taste vor REPEAT_START losgelassen wurde.
  uint8_t i;

  ATOMIC_BLOCK(ATOMIC_FORCEON)
    i = get_key_press( ~key_state & key_mask );
  return i;
}

uint8_t get_key_long( uint8_t key_mask ) {
// true, wenn Taste nach REPEAT_START losgelassen wurde.
  return get_key_press( get_key_rpt( key_mask ));
}

uint8_t get_key_long_r( uint8_t key_mask )      // if repeat function needed
{
  return get_key_press( get_key_rpt( key_press & key_mask ));
}

uint8_t get_key_rpt_l( uint8_t key_mask )       // if long function needed
{
  return get_key_rpt( ~key_press & key_mask );
}

void getKey(uint8_t key_mask) {
  if ( get_key_short( key_mask )) {
    key = SHORT_KEY;
  } else if (get_key_long( key_mask )) {
    key = IMPROPER_KEY;
    longKeyCnt = 0;
  } else if ((key==IMPROPER_KEY) && (longKeyCnt>VERY_LONG_CNTS)) {
    key = VERYLONG_KEY;
  } else if ((key==IMPROPER_KEY) && !(key_state & key_mask)) {
    key = LONG_KEY;
  }
}

