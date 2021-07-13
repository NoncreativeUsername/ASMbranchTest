.text
.global main

//switch and led addresses
.set LED_CTL, 0x41210000
.set SW_DATA, 0x41220000
.set BTN_DATA, 0x41200000

main:
	ldr r1,=SW_DATA		//load sw addresses into r1
	ldr r2,=LED_CTL		//load led addresses into r2

loop:
	ldr r0, [r1]		//load switch values *r1 ->r0
	cmp r0, #255
	bge led_light1		//r0 >= 255 then goto led_light1
	cmp r0, #25
	bge led_light		//r0 >= 25 goto led_light

led_dim:
	mov r0, #0			//all leds off
	str r0, [r2]
	b loop				//goto loop

led_light:
	mov r0, #1			//first led on
	str r0, [r2]		//store r0 ->*r2
	b loop				//go to loop

led_light1:
	mov r0, #3			//first 2 leds on
	str r0, [r2]		//store r0 ->*r2
	b loop				//goto loop

.end
