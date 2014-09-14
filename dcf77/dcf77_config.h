/*
 * dcf77_config.h
 *
 *  Created on: 25.06.2010
 *      Author: harry
 */

#ifndef DCF77_CONFIG_H_
#define DCF77_CONFIG_H_

#ifndef DCF77_PIN
#define DCF77_PIN PIND
#endif
#ifndef DCF77_PORT
#define DCF77_PORT PORTD
#endif
#ifndef DCF77_DDR
#define DCF77_DDR DDRD
#endif
#ifndef DCF77
#define DCF77 PD3
#endif

// #define DCF77_INVERTED        // uncomment if Signal is active Low


#endif /* DCF77_CONFIG_H_ */
