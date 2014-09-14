# LED-DCF77-Wecker (radio controled LED alarm clock)

```
                               -------
                              /       \
+------------------------------------------------------------------+
|                         +-------------------------------------+  |
|                         | *******  *******   *******  ******* |  |
|                         | *     *  *     *   *     *  *     * |  |
|                         | *     *  *     * * *     *  *     * |  |
|                    Zeit | *******  *******   *******  ******* |  |
|                         | *     *  *     * * *     *  *     * |  |
|                         | *     *  *     *   *     *  *     * |  |
|                         | *******  *******   *******  ******* |  |
|                         +-------------------------------------+  |
|                                     +-------------------------+  |
|                                     | ****  ****   ****  **** |  |
|                    Indikator **     | *  *  *  *   *  *  *  * |  |
|                              **     | ****  ****   ****  **** |  |
|                                     | *  *  *  *   *  *  *  * |  |
|                    Datum / Sekunden | ****  **** * ****  **** |  |
|                                     +-------------------------+  |
+------------------------------------------------------------------+
```

## Hardware-Komponenten

- 7-Segment-LED-Display 1.2" mit I2C-Interface ([Adafruit](http://www.adafruit.com/product/1269), auf Basis von HT16K33) zur Anzeige der Uhrzeit
- 7-Segment-LED-Display 0.56" mit I2C-Interface ([Adafruit](http://www.adafruit.com/product/879), auf Basis von HT16K33) zur Anzeige des Datums oder der Sekunden
- Alphanumerisches LCD-Display mit I2C-Interface (4x20, auf Basis von PCF8574, z.B. [hier](http://www.amazon.de/gp/product/B007XRHBKA) zu finden) zum Debugging
- Arduino Pro Mini 328 - 5V/16MHz ([SparkFun](https://www.sparkfun.com/products/11113))
- DCF-Empfangsmodul ([ELV](http://www.elv.de/output/controller.aspx?cid=74&detail=10&detail2=28116))

## Software-Komponenten

- DCF77-C-Bibliothek ([»DCF77 Uhr in C mit ATtiny26«](http://www.mikrocontroller.net/topic/58769))
- I2C-C-Bibliothek ([»I2C Master Interface«](http://homepage.hispeed.ch/peterfleury/avr-software.html))
- I2C/LCD-C-Bibliothek ([»I2CLCD Library für HD44780 LCDs«](http://www.mikrocontroller.net/topic/334653))
- I2C/LED-C-Routinen ([»Add a Seven-Segment LED Display to your AVR microcontroller«](http://w8bh.net/avr/AvrSSD1.pdf))









