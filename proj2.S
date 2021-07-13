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
	ldr r0, [r1]			//load switch values *r1 ->r0
	and r0, #0x0000000F		//mask switches higher than 4

	//light up certain led based on binary value of switches
	cmp r0, #0b11
	ble led1				//switches <= 3 goto led1
	cmp r0, #0b111
	ble led2				//switches <= 7 goto led 2
	cmp r0, #0b1011
	ble led3				//switches <= 11 goto led 3

	//default light up led 3
	mov r0, #8				//if switches greater than 11, load binary 1000 to light led 3
	str r0, [r2]			//store value into led
	b loop					//return to loop

led1:
	mov r0, #1				//if switches greater than 11, load binary 0001 to light led 0
	str r0, [r2]			//store value into led
	b loop					//return to loop

led2:
	mov r0, #2				//if switches greater than 11, load binary 0010 to light led 1
	str r0, [r2]			//store value into led
	b loop					//return to loop

led3:
	mov r0, #4				//if switches greater than 11, load binary 0100 to light led 2
	str r0, [r2]			//store value into led
	b loop					//return to loop
.end
