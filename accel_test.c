/************************************************
*Author: Gentry Atkinson
*Organization: Bobcat Robotics
*Date: 03 Apr 2020
*Description: this will read a SparkFun LIS3DH 3-axis accelerometer and use the
  value of one axis to set... like an LED or something.
************************************************/

#include <pololu/orangutan.h>

//Connected pins on Baby Orangutan. Change to fit your setup
#define headlight_pin IO_D7
#define throttle_pin IO_B1
#define steering_pin IO_B0
#define ch3_pin IO_B2

#define sda_pin IO_C4
#define scl_pin IO_C5
#define adc_read_pin IO_A7

#define adc_channel 7

//For pulse_in
#define LOW_PULSE   1
#define HIGH_PULSE  2
#define ANY_PULSE   3

int main (){
  set_motors(0, 0);
  set_analog_mode(MODE_10_BIT);
  set_digital_output(headlight_pin, LOW);

  while(1){
     if(analog_read(adc_channel) > 512){
       set_digital_output(headlight_pin, HIGH);
     }
     else set_digital_output(headlight_pin, LOW);
     delay_ms(100);
  }
  return 0;
}
