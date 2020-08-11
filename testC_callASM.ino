//http://ww1.microchip.com/downloads/en/appnotes/doc42055.pdf
//https://www.avrfreaks.net/forum/advanced-c-assembly-mixing
//2020-AUG-10, test mix code of ASM and C++ for avr-gcc, xiaolaba
// Arduino IDE 1.8.12
//


#include <avr/io.h> // avr io register names, PORTB & PB5 is used, named & defined here





//function prototype for C++ compiler
extern "C" {
  void LED_FLASH(uint8_t); // for C++ version, Arduino IDE 1.8.12.
  void LED_TOGGLE(void); // for C++ version, Arduino IDE 1.8.12.
}

// function prototype for C compiler
extern void LED_FLASH(uint8_t); // for C version
extern void LED_TOGGLE(void); // for C version



// Assembler function is external, avr-gcc uses register r24 to pass argument or parameter when calling
// Global variable accessible by assembler code and C code
uint8_t value;

int main(void) {
  
  DDRB = 255;
  PORTB = 0;

  while(1) {
    // CHANGE LED PWM DELAY VALUE
    //value++;
    //LEDFLASH(value);  // parameter pass to ASM routine, r24 used
    
    LED_TOGGLE(); // call ASM subroutine, no parameter
  }
//  return 0; // dummy, never get here
}
