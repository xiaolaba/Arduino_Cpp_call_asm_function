//http://ww1.microchip.com/downloads/en/appnotes/doc42055.pdf
//https://www.avrfreaks.net/forum/advanced-c-assembly-mixing
//2020-08-10, test mix code of ASM and C++ for avr-gcc
// Arduino IDE 1.8.12

// The following two lines must be included in every assembly language
// function. They are needed to allow the use of the port names and IN and OUT
// instructions
#define _SFR_ASM_COMPAT 1
#define __SFR_OFFSET 0

//r0, r31, r18-r27, assembler rotine can be used freely, C call to this assembler fucntion

#include <avr/io.h> // avr io register names, PORTB & PB5 is used, named & defined here

.global LEDFLASH  // avr-gcc will see this as subroutine and callable

LED_FLASH:   //Parameter passed by caller in r24

// TURN ON LED, Arduino Nano D13, LED = PB5
//  ldi r20,255
  ldi r20,1<<PB5
  out PORTB,r20

// DELAY BASED ON VALUE R24 = PARAMETER
  ser r20
dl1:
  dec r20
  brne dl1

  ser r20
  dec r24
  brne dl1

// TURN OFF LED
  ldi r20,0
  out PORTB,r20

// FIXED DELAY, 255x255x20 dummy loop
  ser r20     //set_register r20 = 0xff =255
  ser r21     //set_register r21 = 0xff =255
  ldi r22,20  //load contant to r22=20
dl2:
  dec r20
  brne dl2
  dec r21
  brne dl2
  dec r22
  brne dl2
ret







//https://hackaday.com/2011/07/09/hardware-xor-for-output-pins-on-avr-microcontrollers/

.global LED_TOGGLE  // avr-gcc will see this as asm subroutine and callable

//r0, r31, r18-r27, assembler rotine can be used freely, C call to this assembler fucntion
LED_TOGGLE: // asm function name

  ldi r20, 0xFF   ;temporarity use intReg2 as a bit mask
  out PINB, r20   ;writing to PINB effectivley does an Exclusive OR on PORTB

// FIXED DELAY, 255x255x20 dummy loop
  ser r20     //set_register r20 = 0xff =255
  ser r21     //set_register r21 = 0xff =255
  ldi r22,20  //load contant to r22=20
dl3:
  dec r20
  brne dl3
  dec r21
  brne dl3
  dec r22
  brne dl3
 
  ret        ;4 cpu cycle
