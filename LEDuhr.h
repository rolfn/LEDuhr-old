
#ifndef LEDUHR_H_
#define LEDUHR_H_

typedef struct {
  uint8_t minute;
  uint8_t hour;
} wakeup_time;

// Some Flag positions for modeflag variable
#define  SHOW_SECONDS 0
#define  WAKEUP 1
#define  ALARM 2
#define  SNOOZE 3


#endif /* LEDUHR_H_ */
