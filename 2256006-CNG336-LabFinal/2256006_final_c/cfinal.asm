
_send_char:

;cfinal.c,15 :: 		void send_char(unsigned char my_char){ // send char function
;cfinal.c,17 :: 		while (!((UCSR0A) & (1 << (UDRE0))));
L_send_char0:
	IN         R16, UCSR0A+0
	SBRC       R16, 5
	JMP        L_send_char1
	JMP        L_send_char0
L_send_char1:
;cfinal.c,18 :: 		UDR0 = my_char;
	OUT        UDR0+0, R2
;cfinal.c,19 :: 		}
L_end_send_char:
	RET
; end of _send_char

_send_string:

;cfinal.c,21 :: 		void send_string(unsigned char* my_string){ // send string function
;cfinal.c,23 :: 		while(*my_string)
L_send_string2:
	MOVW       R30, R2
	LD         R16, Z
	TST        R16
	BRNE       L__send_string64
	JMP        L_send_string3
L__send_string64:
;cfinal.c,24 :: 		send_char(*my_string++);
	MOVW       R30, R2
	LD         R16, Z
	PUSH       R3
	PUSH       R2
	MOV        R2, R16
	CALL       _send_char+0
	POP        R2
	POP        R3
	MOVW       R16, R2
	SUBI       R16, 255
	SBCI       R17, 255
	MOVW       R2, R16
	JMP        L_send_string2
L_send_string3:
;cfinal.c,25 :: 		}
L_end_send_string:
	RET
; end of _send_string

_clear_every_thing:

;cfinal.c,28 :: 		void clear_every_thing(unsigned char* my_data, unsigned int ADDR)
;cfinal.c,30 :: 		int i = 0;  // it clears everything in the given adress i used to clear usart
	PUSH       R6
;cfinal.c,31 :: 		memset(my_data, 0, 0x50);
	PUSH       R5
	PUSH       R4
	LDI        R27, 80
	MOV        R5, R27
	LDI        R27, 0
	MOV        R6, R27
	CLR        R4
	CALL       _memset+0
	POP        R4
	POP        R5
;cfinal.c,32 :: 		my_data = ADDR;
	MOVW       R2, R4
;cfinal.c,33 :: 		}
L_end_clear_every_thing:
	POP        R6
	RET
; end of _clear_every_thing

_int_to_String:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 4
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;cfinal.c,35 :: 		unsigned char* int_to_String(unsigned int x) { //int to string convertion function
;cfinal.c,36 :: 		unsigned char converted[4]="";
	LDI        R27, 0
	STD        Y+0, R27
	LDI        R27, 0
	STD        Y+1, R27
	LDI        R27, 0
	STD        Y+2, R27
	LDI        R27, 0
	STD        Y+3, R27
;cfinal.c,37 :: 		unsigned int initial_value = x;
; initial_value start address is: 16 (R16)
	MOVW       R16, R2
;cfinal.c,40 :: 		if(initial_value==100){ // look up table for 3 digit number and 1 digit number
	LDI        R27, 0
	CP         R3, R27
	BRNE       L__int_to_String67
	LDI        R27, 100
	CP         R2, R27
L__int_to_String67:
	BREQ       L__int_to_String68
	JMP        L_int_to_String4
L__int_to_String68:
; initial_value end address is: 16 (R16)
;cfinal.c,41 :: 		return "100";
	LDI        R16, #lo_addr(?lstr1_cfinal+0)
	LDI        R17, hi_addr(?lstr1_cfinal+0)
	JMP        L_end_int_to_String
;cfinal.c,42 :: 		}
L_int_to_String4:
;cfinal.c,43 :: 		if(initial_value==0){
; initial_value start address is: 16 (R16)
	CPI        R17, 0
	BRNE       L__int_to_String69
	CPI        R16, 0
L__int_to_String69:
	BREQ       L__int_to_String70
	JMP        L_int_to_String5
L__int_to_String70:
; initial_value end address is: 16 (R16)
;cfinal.c,44 :: 		return "0";
	LDI        R16, #lo_addr(?lstr2_cfinal+0)
	LDI        R17, hi_addr(?lstr2_cfinal+0)
	JMP        L_end_int_to_String
;cfinal.c,45 :: 		}
L_int_to_String5:
;cfinal.c,46 :: 		if(initial_value==1){
; initial_value start address is: 16 (R16)
	CPI        R17, 0
	BRNE       L__int_to_String71
	CPI        R16, 1
L__int_to_String71:
	BREQ       L__int_to_String72
	JMP        L_int_to_String6
L__int_to_String72:
; initial_value end address is: 16 (R16)
;cfinal.c,47 :: 		return "1";
	LDI        R16, #lo_addr(?lstr3_cfinal+0)
	LDI        R17, hi_addr(?lstr3_cfinal+0)
	JMP        L_end_int_to_String
;cfinal.c,48 :: 		}
L_int_to_String6:
;cfinal.c,49 :: 		if(initial_value==2){
; initial_value start address is: 16 (R16)
	CPI        R17, 0
	BRNE       L__int_to_String73
	CPI        R16, 2
L__int_to_String73:
	BREQ       L__int_to_String74
	JMP        L_int_to_String7
L__int_to_String74:
; initial_value end address is: 16 (R16)
;cfinal.c,50 :: 		return "2";
	LDI        R16, #lo_addr(?lstr4_cfinal+0)
	LDI        R17, hi_addr(?lstr4_cfinal+0)
	JMP        L_end_int_to_String
;cfinal.c,51 :: 		}
L_int_to_String7:
;cfinal.c,52 :: 		if(initial_value==3){
; initial_value start address is: 16 (R16)
	CPI        R17, 0
	BRNE       L__int_to_String75
	CPI        R16, 3
L__int_to_String75:
	BREQ       L__int_to_String76
	JMP        L_int_to_String8
L__int_to_String76:
; initial_value end address is: 16 (R16)
;cfinal.c,53 :: 		return "3";
	LDI        R16, #lo_addr(?lstr5_cfinal+0)
	LDI        R17, hi_addr(?lstr5_cfinal+0)
	JMP        L_end_int_to_String
;cfinal.c,54 :: 		}
L_int_to_String8:
;cfinal.c,55 :: 		if(initial_value==4){
; initial_value start address is: 16 (R16)
	CPI        R17, 0
	BRNE       L__int_to_String77
	CPI        R16, 4
L__int_to_String77:
	BREQ       L__int_to_String78
	JMP        L_int_to_String9
L__int_to_String78:
; initial_value end address is: 16 (R16)
;cfinal.c,56 :: 		return "4";
	LDI        R16, #lo_addr(?lstr6_cfinal+0)
	LDI        R17, hi_addr(?lstr6_cfinal+0)
	JMP        L_end_int_to_String
;cfinal.c,57 :: 		}
L_int_to_String9:
;cfinal.c,58 :: 		if(initial_value==5){
; initial_value start address is: 16 (R16)
	CPI        R17, 0
	BRNE       L__int_to_String79
	CPI        R16, 5
L__int_to_String79:
	BREQ       L__int_to_String80
	JMP        L_int_to_String10
L__int_to_String80:
; initial_value end address is: 16 (R16)
;cfinal.c,59 :: 		return "5";
	LDI        R16, #lo_addr(?lstr7_cfinal+0)
	LDI        R17, hi_addr(?lstr7_cfinal+0)
	JMP        L_end_int_to_String
;cfinal.c,60 :: 		}
L_int_to_String10:
;cfinal.c,61 :: 		if(initial_value==6){
; initial_value start address is: 16 (R16)
	CPI        R17, 0
	BRNE       L__int_to_String81
	CPI        R16, 6
L__int_to_String81:
	BREQ       L__int_to_String82
	JMP        L_int_to_String11
L__int_to_String82:
; initial_value end address is: 16 (R16)
;cfinal.c,62 :: 		return "6";
	LDI        R16, #lo_addr(?lstr8_cfinal+0)
	LDI        R17, hi_addr(?lstr8_cfinal+0)
	JMP        L_end_int_to_String
;cfinal.c,63 :: 		}
L_int_to_String11:
;cfinal.c,64 :: 		if(initial_value==7){
; initial_value start address is: 16 (R16)
	CPI        R17, 0
	BRNE       L__int_to_String83
	CPI        R16, 7
L__int_to_String83:
	BREQ       L__int_to_String84
	JMP        L_int_to_String12
L__int_to_String84:
; initial_value end address is: 16 (R16)
;cfinal.c,65 :: 		return "7";
	LDI        R16, #lo_addr(?lstr9_cfinal+0)
	LDI        R17, hi_addr(?lstr9_cfinal+0)
	JMP        L_end_int_to_String
;cfinal.c,66 :: 		}
L_int_to_String12:
;cfinal.c,67 :: 		if(initial_value==8){
; initial_value start address is: 16 (R16)
	CPI        R17, 0
	BRNE       L__int_to_String85
	CPI        R16, 8
L__int_to_String85:
	BREQ       L__int_to_String86
	JMP        L_int_to_String13
L__int_to_String86:
; initial_value end address is: 16 (R16)
;cfinal.c,68 :: 		return "8";
	LDI        R16, #lo_addr(?lstr10_cfinal+0)
	LDI        R17, hi_addr(?lstr10_cfinal+0)
	JMP        L_end_int_to_String
;cfinal.c,69 :: 		}
L_int_to_String13:
;cfinal.c,70 :: 		if(initial_value==9){
; initial_value start address is: 16 (R16)
	CPI        R17, 0
	BRNE       L__int_to_String87
	CPI        R16, 9
L__int_to_String87:
	BREQ       L__int_to_String88
	JMP        L_int_to_String14
L__int_to_String88:
; initial_value end address is: 16 (R16)
;cfinal.c,71 :: 		return "9";
	LDI        R16, #lo_addr(?lstr11_cfinal+0)
	LDI        R17, hi_addr(?lstr11_cfinal+0)
	JMP        L_end_int_to_String
;cfinal.c,72 :: 		}
L_int_to_String14:
;cfinal.c,73 :: 		if(x==0)
	LDI        R27, 0
	CP         R3, R27
	BRNE       L__int_to_String89
	LDI        R27, 0
	CP         R2, R27
L__int_to_String89:
	BREQ       L__int_to_String90
	JMP        L_int_to_String15
L__int_to_String90:
;cfinal.c,75 :: 		*converted = '0';
	MOVW       R30, R28
	LDI        R27, 48
	ST         Z, R27
;cfinal.c,76 :: 		*(converted + 1) = '\0';
	MOVW       R16, R28
	MOVW       R30, R16
	ADIW       R30, 1
	LDI        R27, 0
	ST         Z, R27
;cfinal.c,77 :: 		return "";
	LDI        R16, #lo_addr(?lstr12_cfinal+0)
	LDI        R17, hi_addr(?lstr12_cfinal+0)
	JMP        L_end_int_to_String
;cfinal.c,78 :: 		}
L_int_to_String15:
;cfinal.c,81 :: 		unsigned int i = 0;
; i start address is: 18 (R18)
	LDI        R18, 0
	LDI        R19, 0
; i end address is: 18 (R18)
;cfinal.c,82 :: 		while(x)
L_int_to_String17:
; i start address is: 18 (R18)
	MOV        R27, R2
	OR         R27, R3
	BRNE       L__int_to_String91
	JMP        L_int_to_String18
L__int_to_String91:
;cfinal.c,84 :: 		unsigned char d = x % 10;
	LDI        R20, 10
	LDI        R21, 0
	MOVW       R16, R2
	CALL       _Div_16x16_U+0
	MOVW       R16, R26
; d start address is: 20 (R20)
	MOV        R20, R16
;cfinal.c,85 :: 		x /= 10;
	PUSH       R20
	LDI        R20, 10
	LDI        R21, 0
	MOVW       R16, R2
	CALL       _Div_16x16_U+0
	MOVW       R16, R24
	POP        R20
	MOVW       R2, R16
;cfinal.c,86 :: 		if(d>9)
	LDI        R16, 9
	CP         R16, R20
	BRLO       L__int_to_String92
	JMP        L_int_to_String19
L__int_to_String92:
;cfinal.c,87 :: 		converted[i++]=(d + 55);// to find its ascii if it is a letter
	MOVW       R16, R28
	MOVW       R30, R18
	ADD        R30, R16
	ADC        R31, R17
	MOV        R16, R20
	SUBI       R16, 201
; d end address is: 20 (R20)
	ST         Z, R16
	MOVW       R16, R18
	SUBI       R16, 255
	SBCI       R17, 255
; i end address is: 18 (R18)
; i start address is: 16 (R16)
	MOVW       R18, R16
; i end address is: 16 (R16)
	JMP        L_int_to_String20
L_int_to_String19:
;cfinal.c,89 :: 		converted[i++]=(d + 48);
; i start address is: 18 (R18)
; d start address is: 20 (R20)
	MOVW       R16, R28
	MOVW       R30, R18
	ADD        R30, R16
	ADC        R31, R17
	MOV        R16, R20
	SUBI       R16, 208
; d end address is: 20 (R20)
	ST         Z, R16
	MOVW       R16, R18
	SUBI       R16, 255
	SBCI       R17, 255
	MOVW       R18, R16
; i end address is: 18 (R18)
L_int_to_String20:
;cfinal.c,90 :: 		}
; i start address is: 18 (R18)
	JMP        L_int_to_String17
L_int_to_String18:
;cfinal.c,92 :: 		converted[i] = '\0';
	MOVW       R16, R28
	MOVW       R30, R18
	ADD        R30, R16
	ADC        R31, R17
; i end address is: 18 (R18)
	LDI        R27, 0
	ST         Z, R27
;cfinal.c,95 :: 		temp_val = converted[0]; //swap operation because now it is in opposite order
	MOV        R17, R28
	MOV        R18, R29
	MOV        R30, R17
	MOV        R31, R18
	LD         R16, Z
; temp_val start address is: 19 (R19)
	MOV        R19, R16
;cfinal.c,96 :: 		converted[0] = converted[1];
	MOV        R30, R17
	MOV        R31, R18
	ADIW       R30, 1
	LD         R16, Z
	MOV        R30, R17
	MOV        R31, R18
	ST         Z, R16
;cfinal.c,97 :: 		converted[1] = temp_val;
	MOVW       R16, R28
	MOVW       R30, R16
	ADIW       R30, 1
	ST         Z, R19
; temp_val end address is: 19 (R19)
;cfinal.c,100 :: 		return converted;
	MOVW       R16, R28
;cfinal.c,102 :: 		}
L_end_int_to_String:
	ADIW       R28, 3
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _int_to_String

_start_noise:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;cfinal.c,105 :: 		void start_noise() iv 0x001E{ // create square wave on portb 4 for motor speed if timer 0 compare handle
;cfinal.c,107 :: 		PORTB.B4 = waves ^ 1;
	LDS        R16, _waves+0
	LDI        R27, 1
	EOR        R16, R27
	BST        R16, 0
	IN         R27, PORTB+0
	BLD        R27, 4
	OUT        PORTB+0, R27
;cfinal.c,109 :: 		}
L_end_start_noise:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _start_noise

_stop_noise:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;cfinal.c,112 :: 		void stop_noise() iv 0x0014 // for stopping noise when timer2 overflow
;cfinal.c,113 :: 		{++sum_twos; // increment until it becomes 2 sec
	LDS        R16, _sum_twos+0
	LDS        R17, _sum_twos+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _sum_twos+0, R16
	STS        _sum_twos+1, R17
;cfinal.c,115 :: 		}
L_end_stop_noise:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _stop_noise

_usart:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;cfinal.c,124 :: 		void usart() iv 0x0024{
;cfinal.c,125 :: 		unsigned int enter = 0;
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
; enter start address is: 18 (R18)
	LDI        R18, 0
	LDI        R19, 0
;cfinal.c,126 :: 		temp = UDR0;
	IN         R16, UDR0+0
	STS        _temp+0, R16
;cfinal.c,129 :: 		if(temp == '\n' || temp == '\r') // check if enter is pressed
	LDS        R16, _temp+0
	CPI        R16, 10
	BRNE       L__usart96
	JMP        L__usart57
L__usart96:
	LDS        R16, _temp+0
	CPI        R16, 13
	BRNE       L__usart97
	JMP        L__usart56
L__usart97:
	JMP        L_usart23
; enter end address is: 18 (R18)
L__usart57:
L__usart56:
;cfinal.c,130 :: 		enter = 1;
; enter start address is: 17 (R17)
	LDI        R17, 1
	LDI        R18, 0
; enter end address is: 17 (R17)
	JMP        L_usart24
L_usart23:
;cfinal.c,132 :: 		{if((unsigned int) my_data < 0x530) { // for getting correct input
; enter start address is: 18 (R18)
	LDS        R16, _my_data+0
	LDS        R17, _my_data+1
	CPI        R17, 5
	BRNE       L__usart98
	CPI        R16, 48
L__usart98:
	BRLO       L__usart99
	JMP        L_usart25
L__usart99:
;cfinal.c,133 :: 		*my_data++ = temp;
	LDS        R16, _temp+0
	LDS        R30, _my_data+0
	LDS        R31, _my_data+1
	ST         Z, R16
	LDS        R16, _my_data+0
	LDS        R17, _my_data+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _my_data+0, R16
	STS        _my_data+1, R17
;cfinal.c,134 :: 		*my_data = '\0';}
	MOVW       R30, R16
	LDI        R27, 0
	ST         Z, R27
L_usart25:
;cfinal.c,135 :: 		}
	MOV        R17, R18
	MOV        R18, R19
L_usart24:
; enter end address is: 18 (R18)
;cfinal.c,136 :: 		UDR0 = temp;
; enter start address is: 17 (R17)
	LDS        R16, _temp+0
	OUT        UDR0+0, R16
;cfinal.c,139 :: 		if(enter)
	MOV        R27, R17
	OR         R27, R18
	BRNE       L__usart100
	JMP        L_usart26
L__usart100:
; enter end address is: 17 (R17)
;cfinal.c,140 :: 		{my_data = 0x500;
	LDI        R27, 0
	STS        _my_data+0, R27
	LDI        R27, 5
	STS        _my_data+1, R27
;cfinal.c,142 :: 		my_flag=1; // flag for adding the unit  % or C
	LDI        R27, 1
	STS        _my_flag+0, R27
	LDI        R27, 0
	STS        _my_flag+1, R27
;cfinal.c,144 :: 		if(!(strcmp(my_data,"T"))){ // if equals will return 0
	LDI        R27, #lo_addr(?lstr13_cfinal+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr13_cfinal+0)
	MOV        R5, R27
	LDI        R27, 0
	MOV        R2, R27
	LDI        R27, 5
	MOV        R3, R27
	CALL       _strcmp+0
	MOV        R27, R16
	OR         R27, R17
	BREQ       L__usart101
	JMP        L_usart27
L__usart101:
;cfinal.c,145 :: 		unit_select=1; //choose % or C
	LDI        R27, 1
	STS        _unit_select+0, R27
	LDI        R27, 0
	STS        _unit_select+1, R27
;cfinal.c,146 :: 		strcpy(text_for_usart, "TEMPERATURE: "); // basic copy string
	LDI        R27, #lo_addr(?lstr14_cfinal+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr14_cfinal+0)
	MOV        R5, R27
	LDI        R27, #lo_addr(_text_for_usart+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_text_for_usart+0)
	MOV        R3, R27
	CALL       _strcpy+0
;cfinal.c,147 :: 		strcpy(temp_for_usart,int_to_String(heat_value));
	LDS        R2, _heat_value+0
	LDS        R3, _heat_value+1
	CALL       _int_to_String+0
	MOVW       R4, R16
	LDI        R27, #lo_addr(_temp_for_usart+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_temp_for_usart+0)
	MOV        R3, R27
	CALL       _strcpy+0
;cfinal.c,148 :: 		strcpy(text_for_usart + strlen("TEMPERATURE: "), temp_for_usart);
	LDI        R27, #lo_addr(?lstr15_cfinal+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr15_cfinal+0)
	MOV        R3, R27
	CALL       _strlen+0
	LDI        R18, #lo_addr(_text_for_usart+0)
	LDI        R19, hi_addr(_text_for_usart+0)
	ADD        R16, R18
	ADC        R17, R19
	LDI        R27, #lo_addr(_temp_for_usart+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_temp_for_usart+0)
	MOV        R5, R27
	MOVW       R2, R16
	CALL       _strcpy+0
;cfinal.c,151 :: 		}
	JMP        L_usart28
L_usart27:
;cfinal.c,152 :: 		else if(!(strcmp(my_data,"S"))){
	LDI        R27, #lo_addr(?lstr16_cfinal+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr16_cfinal+0)
	MOV        R5, R27
	LDS        R2, _my_data+0
	LDS        R3, _my_data+1
	CALL       _strcmp+0
	MOV        R27, R16
	OR         R27, R17
	BREQ       L__usart102
	JMP        L_usart29
L__usart102:
;cfinal.c,153 :: 		unit_select=2;//same as above
	LDI        R27, 2
	STS        _unit_select+0, R27
	LDI        R27, 0
	STS        _unit_select+1, R27
;cfinal.c,154 :: 		strcpy(text_for_usart, "FAN SPEED: ");
	LDI        R27, #lo_addr(?lstr17_cfinal+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr17_cfinal+0)
	MOV        R5, R27
	LDI        R27, #lo_addr(_text_for_usart+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_text_for_usart+0)
	MOV        R3, R27
	CALL       _strcpy+0
;cfinal.c,155 :: 		strcpy(temp_for_usart,int_to_String(fan_speed));
	LDS        R2, _fan_speed+0
	LDS        R3, _fan_speed+1
	CALL       _int_to_String+0
	MOVW       R4, R16
	LDI        R27, #lo_addr(_temp_for_usart+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_temp_for_usart+0)
	MOV        R3, R27
	CALL       _strcpy+0
;cfinal.c,156 :: 		strcpy(text_for_usart + strlen("FAN SPEED: "), temp_for_usart);
	LDI        R27, #lo_addr(?lstr18_cfinal+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr18_cfinal+0)
	MOV        R3, R27
	CALL       _strlen+0
	LDI        R18, #lo_addr(_text_for_usart+0)
	LDI        R19, hi_addr(_text_for_usart+0)
	ADD        R16, R18
	ADC        R17, R19
	LDI        R27, #lo_addr(_temp_for_usart+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_temp_for_usart+0)
	MOV        R5, R27
	MOVW       R2, R16
	CALL       _strcpy+0
;cfinal.c,159 :: 		}
	JMP        L_usart30
L_usart29:
;cfinal.c,162 :: 		send_string("Wrong input entered, Please "); // another input
	LDI        R27, #lo_addr(?lstr19_cfinal+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr19_cfinal+0)
	MOV        R3, R27
	CALL       _send_string+0
;cfinal.c,163 :: 		my_flag=0; // flag will choose wrong input message
	LDI        R27, 0
	STS        _my_flag+0, R27
	STS        _my_flag+1, R27
;cfinal.c,164 :: 		}
L_usart30:
L_usart28:
;cfinal.c,165 :: 		if(my_flag==1){
	LDS        R16, _my_flag+0
	LDS        R17, _my_flag+1
	CPI        R17, 0
	BRNE       L__usart103
	CPI        R16, 1
L__usart103:
	BREQ       L__usart104
	JMP        L_usart31
L__usart104:
;cfinal.c,166 :: 		if(unit_select==1)
	LDS        R16, _unit_select+0
	LDS        R17, _unit_select+1
	CPI        R17, 0
	BRNE       L__usart105
	CPI        R16, 1
L__usart105:
	BREQ       L__usart106
	JMP        L_usart32
L__usart106:
;cfinal.c,167 :: 		strcpy(text_for_usart + strlen("TEMPERATURE: ") + strlen(temp_for_usart), "C\r"); //explained above
	LDI        R27, #lo_addr(?lstr20_cfinal+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr20_cfinal+0)
	MOV        R3, R27
	CALL       _strlen+0
	LDI        R18, #lo_addr(_text_for_usart+0)
	LDI        R19, hi_addr(_text_for_usart+0)
	ADD        R16, R18
	ADC        R17, R19
	STD        Y+0, R16
	STD        Y+1, R17
	LDI        R27, #lo_addr(_temp_for_usart+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_temp_for_usart+0)
	MOV        R3, R27
	CALL       _strlen+0
	LDD        R18, Y+0
	LDD        R19, Y+1
	ADD        R16, R18
	ADC        R17, R19
	LDI        R27, #lo_addr(?lstr21_cfinal+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr21_cfinal+0)
	MOV        R5, R27
	MOVW       R2, R16
	CALL       _strcpy+0
L_usart32:
;cfinal.c,169 :: 		if(unit_select==2)
	LDS        R16, _unit_select+0
	LDS        R17, _unit_select+1
	CPI        R17, 0
	BRNE       L__usart107
	CPI        R16, 2
L__usart107:
	BREQ       L__usart108
	JMP        L_usart33
L__usart108:
;cfinal.c,170 :: 		strcpy(text_for_usart + strlen("FAN SPEED: ") + strlen(temp_for_usart), "%\r"); //explained above
	LDI        R27, #lo_addr(?lstr22_cfinal+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr22_cfinal+0)
	MOV        R3, R27
	CALL       _strlen+0
	LDI        R18, #lo_addr(_text_for_usart+0)
	LDI        R19, hi_addr(_text_for_usart+0)
	ADD        R16, R18
	ADC        R17, R19
	STD        Y+0, R16
	STD        Y+1, R17
	LDI        R27, #lo_addr(_temp_for_usart+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_temp_for_usart+0)
	MOV        R3, R27
	CALL       _strlen+0
	LDD        R18, Y+0
	LDD        R19, Y+1
	ADD        R16, R18
	ADC        R17, R19
	LDI        R27, #lo_addr(?lstr23_cfinal+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr23_cfinal+0)
	MOV        R5, R27
	MOVW       R2, R16
	CALL       _strcpy+0
L_usart33:
;cfinal.c,172 :: 		send_string(text_for_usart);
	LDI        R27, #lo_addr(_text_for_usart+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_text_for_usart+0)
	MOV        R3, R27
	CALL       _send_string+0
;cfinal.c,173 :: 		}
L_usart31:
;cfinal.c,177 :: 		clear_every_thing(my_data, 0x500); // clear the data so last data value it wont be seen while asking input
	LDI        R27, 0
	MOV        R4, R27
	LDI        R27, 5
	MOV        R5, R27
	LDS        R2, _my_data+0
	LDS        R3, _my_data+1
	CALL       _clear_every_thing+0
;cfinal.c,178 :: 		send_string("Enter S for % fan speed and T for temperature:");
	LDI        R27, #lo_addr(?lstr24_cfinal+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr24_cfinal+0)
	MOV        R3, R27
	CALL       _send_string+0
;cfinal.c,182 :: 		}
L_usart26:
;cfinal.c,186 :: 		}
L_end_usart:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _usart

_all_calculations:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;cfinal.c,198 :: 		void all_calculations() iv 0x002A //adc function
;cfinal.c,200 :: 		second_adc = ADCL;
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	IN         R16, ADCL+0
	STS        _second_adc+0, R16
	LDI        R27, 0
	STS        _second_adc+1, R27
;cfinal.c,201 :: 		second_adc += (ADCH & 0x03) << 8; // hence value max 10 bit we should take first 2 bits of high and shift it 8 bits left
	IN         R16, ADCH+0
	ANDI       R16, 3
	MOV        R19, R16
	CLR        R18
	LDS        R16, _second_adc+0
	LDS        R17, _second_adc+1
	ADD        R18, R16
	ADC        R19, R17
	STS        _second_adc+0, R18
	STS        _second_adc+1, R19
;cfinal.c,202 :: 		if(first_adc != second_adc) // if them changed
	LDS        R16, _first_adc+0
	LDS        R17, _first_adc+1
	CP         R16, R18
	CPC        R17, R19
	BRNE       L__all_calculations110
	JMP        L_all_calculations34
L__all_calculations110:
;cfinal.c,203 :: 		{first_adc = second_adc; //store the
	LDS        R16, _second_adc+0
	LDS        R17, _second_adc+1
	STS        _first_adc+0, R16
	STS        _first_adc+1, R17
;cfinal.c,205 :: 		heat_value = (second_adc * 0.098); // heat = 5/1023/50 mV * (10 bit value)
	LDS        R16, _second_adc+0
	LDS        R17, _second_adc+1
	LDI        R18, 0
	MOV        R19, R18
	CALL       _float_ulong2fp+0
	LDI        R20, 57
	LDI        R21, 180
	LDI        R22, 200
	LDI        R23, 61
	CALL       _float_fpmul1+0
	CALL       _float_fpint+0
	STS        _heat_value+0, R16
	STS        _heat_value+1, R17
;cfinal.c,206 :: 		if(heat_value < 30) // if new heat value <30
	CPI        R17, 0
	BRNE       L__all_calculations111
	CPI        R16, 30
L__all_calculations111:
	BRLO       L__all_calculations112
	JMP        L_all_calculations35
L__all_calculations112:
;cfinal.c,208 :: 		buzzer_2 = 0; // buzzer will not sound
	LDI        R27, 0
	STS        _buzzer_2+0, R27
;cfinal.c,209 :: 		fan_speed = 0; //fan speed will be 0
	LDI        R27, 0
	STS        _fan_speed+0, R27
	STS        _fan_speed+1, R27
;cfinal.c,210 :: 		if(motor) // if motor already active
	LDS        R16, _motor+0
	TST        R16
	BRNE       L__all_calculations113
	JMP        L_all_calculations36
L__all_calculations113:
;cfinal.c,212 :: 		((TIMSK) &= ~(1 << (OCIE0))); // disable interrupt for timer0
	IN         R27, TIMSK+0
	CBR        R27, 2
	OUT        TIMSK+0, R27
;cfinal.c,213 :: 		waves = 0; // make waves variable 0 so when next time interrupt it will create waves on portb4
	LDI        R27, 0
	STS        _waves+0, R27
;cfinal.c,214 :: 		PORTB.B4 = 0; // but no need because heat < 30
	IN         R27, PORTB+0
	CBR        R27, 16
	OUT        PORTB+0, R27
;cfinal.c,215 :: 		motor = 0; // motor shouldnt work under 30 C
	LDI        R27, 0
	STS        _motor+0, R27
;cfinal.c,216 :: 		}
L_all_calculations36:
;cfinal.c,217 :: 		if(buzzer_1) //this condition is for high to low temp which means buzzer1 is already set but now we are under 30 C
	LDS        R16, _buzzer_1+0
	TST        R16
	BRNE       L__all_calculations114
	JMP        L_all_calculations37
L__all_calculations114:
;cfinal.c,218 :: 		{((TIMSK) &= ~(1 << (TOIE2))); // disable timer2 interrupt
	IN         R16, TIMSK+0
	ANDI       R16, 191
	OUT        TIMSK+0, R16
;cfinal.c,219 :: 		TCNT2 = 0; //load 0 to timer 2
	LDI        R27, 0
	OUT        TCNT2+0, R27
;cfinal.c,220 :: 		buzzer_1 = 0; // now buzzer1 should be 0
	LDI        R27, 0
	STS        _buzzer_1+0, R27
;cfinal.c,221 :: 		}
L_all_calculations37:
;cfinal.c,222 :: 		}
	JMP        L_all_calculations38
L_all_calculations35:
;cfinal.c,225 :: 		fan_speed = 100*(heat_value-30)/70; // calculate fan speed
	LDS        R16, _heat_value+0
	LDS        R17, _heat_value+1
	SUBI       R16, 30
	SBCI       R17, 0
	LDI        R20, 100
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R20, 70
	LDI        R21, 0
	CALL       _Div_16x16_U+0
	MOVW       R16, R24
	STS        _fan_speed+0, R16
	STS        _fan_speed+1, R17
;cfinal.c,226 :: 		if(!motor) //if low to high
	LDS        R16, _motor+0
	TST        R16
	BREQ       L__all_calculations115
	JMP        L_all_calculations39
L__all_calculations115:
;cfinal.c,227 :: 		TIMSK |= 1 << (OCIE0); // start timer 0 to make noise
	IN         R16, TIMSK+0
	ORI        R16, 2
	OUT        TIMSK+0, R16
L_all_calculations39:
;cfinal.c,228 :: 		motor = 1; //now motor is active
	LDI        R27, 1
	STS        _motor+0, R27
;cfinal.c,229 :: 		}
L_all_calculations38:
;cfinal.c,231 :: 		OCR0 = (fan_speed * 255) / 100; // load needed value to ocr0 (motor speed)
	LDS        R16, _fan_speed+0
	LDS        R17, _fan_speed+1
	LDI        R20, 255
	LDI        R21, 0
	CALL       _HWMul_16x16+0
	LDI        R20, 100
	LDI        R21, 0
	CALL       _Div_16x16_U+0
	MOVW       R16, R24
	OUT        OCR0+0, R16
;cfinal.c,232 :: 		strcpy(lcd_up, "TEMPERATURE:");
	LDI        R27, #lo_addr(?lstr25_cfinal+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr25_cfinal+0)
	MOV        R5, R27
	LDS        R2, _lcd_up+0
	LDS        R3, _lcd_up+1
	CALL       _strcpy+0
;cfinal.c,233 :: 		strcpy(temp_for_usart,int_to_String(heat_value));
	LDS        R2, _heat_value+0
	LDS        R3, _heat_value+1
	CALL       _int_to_String+0
	MOVW       R4, R16
	LDI        R27, #lo_addr(_temp_for_usart+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_temp_for_usart+0)
	MOV        R3, R27
	CALL       _strcpy+0
;cfinal.c,234 :: 		strcpy(lcd_up + 12, temp_for_usart);
	LDS        R16, _lcd_up+0
	LDS        R17, _lcd_up+1
	SUBI       R16, 244
	SBCI       R17, 255
	LDI        R27, #lo_addr(_temp_for_usart+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_temp_for_usart+0)
	MOV        R5, R27
	MOVW       R2, R16
	CALL       _strcpy+0
;cfinal.c,235 :: 		len_temperature = strlen(temp_for_usart);
	LDI        R27, #lo_addr(_temp_for_usart+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_temp_for_usart+0)
	MOV        R3, R27
	CALL       _strlen+0
	STS        _len_temperature+0, R16
;cfinal.c,236 :: 		lcd_up[12 + len_temperature] = 'C';
	MOV        R18, R16
	LDI        R19, 0
	SUBI       R18, 244
	SBCI       R19, 255
	LDS        R16, _lcd_up+0
	LDS        R17, _lcd_up+1
	MOVW       R30, R18
	ADD        R30, R16
	ADC        R31, R17
	LDI        R27, 67
	ST         Z, R27
;cfinal.c,237 :: 		memset(lcd_up + 13 + len_temperature, ' ', 11 - len_temperature);
	LDS        R0, _len_temperature+0
	LDI        R27, 0
	MOV        R1, R27
	LDI        R20, 11
	LDI        R21, 0
	SUB        R20, R0
	SBC        R21, R1
	LDS        R16, _lcd_up+0
	LDS        R17, _lcd_up+1
	MOVW       R18, R16
	SUBI       R18, 243
	SBCI       R19, 255
	LDS        R16, _len_temperature+0
	LDI        R17, 0
	ADD        R16, R18
	ADC        R17, R19
	MOV        R5, R20
	MOV        R6, R21
	LDI        R27, 32
	MOV        R4, R27
	MOVW       R2, R16
	CALL       _memset+0
;cfinal.c,238 :: 		strcpy(lcd_down, "FAN SPEED:");
	LDI        R27, #lo_addr(?lstr26_cfinal+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr26_cfinal+0)
	MOV        R5, R27
	LDS        R2, _lcd_down+0
	LDS        R3, _lcd_down+1
	CALL       _strcpy+0
;cfinal.c,239 :: 		strcpy(temp_for_usart,int_to_String(fan_speed));
	LDS        R2, _fan_speed+0
	LDS        R3, _fan_speed+1
	CALL       _int_to_String+0
	MOVW       R4, R16
	LDI        R27, #lo_addr(_temp_for_usart+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_temp_for_usart+0)
	MOV        R3, R27
	CALL       _strcpy+0
;cfinal.c,240 :: 		strcpy(lcd_down + 10, temp_for_usart);
	LDS        R16, _lcd_down+0
	LDS        R17, _lcd_down+1
	SUBI       R16, 246
	SBCI       R17, 255
	LDI        R27, #lo_addr(_temp_for_usart+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_temp_for_usart+0)
	MOV        R5, R27
	MOVW       R2, R16
	CALL       _strcpy+0
;cfinal.c,241 :: 		len_temperature = strlen(temp_for_usart);
	LDI        R27, #lo_addr(_temp_for_usart+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_temp_for_usart+0)
	MOV        R3, R27
	CALL       _strlen+0
	STS        _len_temperature+0, R16
;cfinal.c,242 :: 		lcd_down[10 + strlen(temp_for_usart)] = '%';
	LDI        R27, #lo_addr(_temp_for_usart+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_temp_for_usart+0)
	MOV        R3, R27
	CALL       _strlen+0
	MOVW       R18, R16
	SUBI       R18, 246
	SBCI       R19, 255
	LDS        R16, _lcd_down+0
	LDS        R17, _lcd_down+1
	MOVW       R30, R18
	ADD        R30, R16
	ADC        R31, R17
	LDI        R27, 37
	ST         Z, R27
;cfinal.c,243 :: 		memset(lcd_down + 11 + len_temperature, ' ', 11 - len_temperature);
	LDS        R0, _len_temperature+0
	LDI        R27, 0
	MOV        R1, R27
	LDI        R20, 11
	LDI        R21, 0
	SUB        R20, R0
	SBC        R21, R1
	LDS        R16, _lcd_down+0
	LDS        R17, _lcd_down+1
	MOVW       R18, R16
	SUBI       R18, 245
	SBCI       R19, 255
	LDS        R16, _len_temperature+0
	LDI        R17, 0
	ADD        R16, R18
	ADC        R17, R19
	MOV        R5, R20
	MOV        R6, R21
	LDI        R27, 32
	MOV        R4, R27
	MOVW       R2, R16
	CALL       _memset+0
;cfinal.c,244 :: 		my_led = ((1 << (second_adc / 127)) - 1) & 0xFF; // led values on port a 5V 100 -> 0.625 V for 12.5 for each led
	LDI        R20, 127
	LDI        R21, 0
	LDS        R16, _second_adc+0
	LDS        R17, _second_adc+1
	CALL       _Div_16x16_U+0
	MOVW       R16, R24
	MOV        R27, R16
	LDI        R16, 1
	TST        R27
	BREQ       L__all_calculations117
L__all_calculations116:
	LSL        R16
	DEC        R27
	BRNE       L__all_calculations116
L__all_calculations117:
	SUBI       R16, 1
	ANDI       R16, 255
	STS        _my_led+0, R16
;cfinal.c,245 :: 		}                     							 // adc/(1024/8)-1
L_all_calculations34:
;cfinal.c,247 :: 		active_switches();
	CALL       _active_switches+0
;cfinal.c,248 :: 		}
L_end_all_calculations:
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _all_calculations

_active_switches:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 32
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;cfinal.c,249 :: 		void active_switches(){ // to check which switches are active
;cfinal.c,250 :: 		if(PIND.B0==1) //display temperature on first line
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	IN         R27, PIND+0
	SBRS       R27, 0
	JMP        L_active_switches40
;cfinal.c,251 :: 		Lcd_Out(1, 1, lcd_up);
	LDS        R4, _lcd_up+0
	LDS        R5, _lcd_up+1
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
	JMP        L_active_switches41
L_active_switches40:
;cfinal.c,255 :: 		memset(temp, ' ', 0x10);
	MOVW       R16, R28
	LDI        R27, 16
	MOV        R5, R27
	LDI        R27, 0
	MOV        R6, R27
	LDI        R27, 32
	MOV        R4, R27
	MOVW       R2, R16
	CALL       _memset+0
;cfinal.c,256 :: 		Lcd_Out(1, 1, temp);}
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_active_switches41:
;cfinal.c,258 :: 		if(PIND.B1==1) //same as above
	IN         R27, PIND+0
	SBRS       R27, 1
	JMP        L_active_switches42
;cfinal.c,259 :: 		Lcd_Out(2, 1, lcd_down);
	LDS        R4, _lcd_down+0
	LDS        R5, _lcd_down+1
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
	JMP        L_active_switches43
L_active_switches42:
;cfinal.c,263 :: 		memset(temp, ' ', 0x10);
	MOVW       R16, R28
	SUBI       R16, 240
	SBCI       R17, 255
	LDI        R27, 16
	MOV        R5, R27
	LDI        R27, 0
	MOV        R6, R27
	LDI        R27, 32
	MOV        R4, R27
	MOVW       R2, R16
	CALL       _memset+0
;cfinal.c,264 :: 		Lcd_Out(2, 1, temp);}
	MOVW       R16, R28
	SUBI       R16, 240
	SBCI       R17, 255
	MOVW       R4, R16
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
L_active_switches43:
;cfinal.c,266 :: 		if(PIND.B2==0) //if buzzer noise switch not active
	IN         R27, PIND+0
	SBRC       R27, 2
	JMP        L_active_switches44
;cfinal.c,268 :: 		buzzer_2 = 0; // make buzzer2 0 for future
	LDI        R27, 0
	STS        _buzzer_2+0, R27
;cfinal.c,269 :: 		if(buzzer_1) // even if it should have been make noise
	LDS        R16, _buzzer_1+0
	TST        R16
	BRNE       L__active_switches119
	JMP        L_active_switches45
L__active_switches119:
;cfinal.c,270 :: 		{((TIMSK) &= ~(1 << (TOIE2))); // disable timer2
	IN         R27, TIMSK+0
	CBR        R27, 64
	OUT        TIMSK+0, R27
;cfinal.c,271 :: 		TCNT2 = 0; //load 0 to timer 2
	LDI        R27, 0
	OUT        TCNT2+0, R27
;cfinal.c,272 :: 		((PORTC) |= (1 << (1))); //portc1 is 1
	IN         R16, PORTC+0
	ORI        R16, 2
	OUT        PORTC+0, R16
;cfinal.c,273 :: 		buzzer_1 = 0;}} //make buzzer1 0 for future
	LDI        R27, 0
	STS        _buzzer_1+0, R27
L_active_switches45:
	JMP        L_active_switches46
L_active_switches44:
;cfinal.c,274 :: 		else if(!buzzer_1 && heat_value > 30 && !buzzer_2) //so prev buzzers are 0 and heat > 30
	LDS        R16, _buzzer_1+0
	TST        R16
	BREQ       L__active_switches120
	JMP        L__active_switches61
L__active_switches120:
	LDS        R18, _heat_value+0
	LDS        R19, _heat_value+1
	LDI        R16, 30
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__active_switches121
	JMP        L__active_switches60
L__active_switches121:
	LDS        R16, _buzzer_2+0
	TST        R16
	BREQ       L__active_switches122
	JMP        L__active_switches59
L__active_switches122:
L__active_switches58:
;cfinal.c,275 :: 		{((TIMSK) |= (1 << (TOIE2))); //enable timer2 overflow interrupt
	IN         R16, TIMSK+0
	ORI        R16, 64
	OUT        TIMSK+0, R16
;cfinal.c,276 :: 		((PORTC) &= ~(1 << (1)));
	IN         R16, PORTC+0
	ANDI       R16, 253
	OUT        PORTC+0, R16
;cfinal.c,277 :: 		buzzer_1 = 1; //made noise become 1
	LDI        R27, 1
	STS        _buzzer_1+0, R27
;cfinal.c,278 :: 		buzzer_2 = 1;}
	LDI        R27, 1
	STS        _buzzer_2+0, R27
;cfinal.c,274 :: 		else if(!buzzer_1 && heat_value > 30 && !buzzer_2) //so prev buzzers are 0 and heat > 30
L__active_switches61:
L__active_switches60:
L__active_switches59:
;cfinal.c,278 :: 		buzzer_2 = 1;}
L_active_switches46:
;cfinal.c,281 :: 		if(PIND.B3==0) //if led display pin inactive
	IN         R27, PIND+0
	SBRC       R27, 3
	JMP        L_active_switches50
;cfinal.c,282 :: 		PORTA = 0; // no display
	LDI        R27, 0
	OUT        PORTA+0, R27
	JMP        L_active_switches51
L_active_switches50:
;cfinal.c,285 :: 		PORTA = my_led; //else display 1 bit for each 12.5 C
	LDS        R16, _my_led+0
	OUT        PORTA+0, R16
L_active_switches51:
;cfinal.c,286 :: 		}
L_end_active_switches:
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 31
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _active_switches

_restart_timer:

;cfinal.c,287 :: 		void restart_timer(){
;cfinal.c,288 :: 		sum_twos = 0; //make it 0
	LDI        R27, 0
	STS        _sum_twos+0, R27
	STS        _sum_twos+1, R27
;cfinal.c,289 :: 		TIMSK &= ~(1 << TOIE2); // Timer2 overflow interrupt disable
	IN         R27, TIMSK+0
	CBR        R27, 64
	OUT        TIMSK+0, R27
;cfinal.c,290 :: 		TCNT2 = 0; //timer2 is again 0
	LDI        R27, 0
	OUT        TCNT2+0, R27
;cfinal.c,291 :: 		PORTC |= 1 << 1; // make PORTC.1 to 1 again
	IN         R16, PORTC+0
	ORI        R16, 2
	OUT        PORTC+0, R16
;cfinal.c,292 :: 		buzzer_1 = 0; // buzzer_1 will become 0 so it will not start
	LDI        R27, 0
	STS        _buzzer_1+0, R27
;cfinal.c,293 :: 		}
L_end_restart_timer:
	RET
; end of _restart_timer

_initialize_ports_and_registers:

;cfinal.c,295 :: 		void initialize_ports_and_registers(){
;cfinal.c,297 :: 		DDRA = 0xFF; // A for led outputs
	PUSH       R2
	LDI        R27, 255
	OUT        DDRA+0, R27
;cfinal.c,299 :: 		DDRC = 0x02; // C1 connection for buzzer
	LDI        R27, 2
	OUT        DDRC+0, R27
;cfinal.c,301 :: 		DDRD = 0xF0; // D7 and D6 for motor connection output
	LDI        R27, 240
	OUT        DDRD+0, R27
;cfinal.c,303 :: 		UCSR0C |= (1 << UCSZ01)|(1 << UCSZ00); // UCR0C init
	LDS        R16, UCSR0C+0
	ORI        R16, 6
	STS        UCSR0C+0, R16
;cfinal.c,305 :: 		UCSR0B |= (1 << RXEN0)| (1 << RXCIE0) | (1 <<TXEN0)  ; // UCSR0B init
	IN         R16, UCSR0B+0
	ORI        R16, 152
	OUT        UCSR0B+0, R16
;cfinal.c,308 :: 		DDRB |=  1 << 4; //portb4 will be connected L293D(motor entegre) EN1
	IN         R27, DDRB+0
	SBR        R27, 16
	OUT        DDRB+0, R27
;cfinal.c,309 :: 		PORTD &= ~(1 << (7)); //portd4 will be connected L293D(motor entegre) IN2
	IN         R16, PORTD+0
	ANDI       R16, 127
	OUT        PORTD+0, R16
;cfinal.c,310 :: 		PORTD |= 1 << 6; //portd4 will be connected L293D(motor entegre) IN1
	ORI        R16, 64
	OUT        PORTD+0, R16
;cfinal.c,311 :: 		PORTC |= 1 << 1; // portc1 will be connected to buzzer
	IN         R16, PORTC+0
	ORI        R16, 2
	OUT        PORTC+0, R16
;cfinal.c,312 :: 		Lcd_Init(); // lcd init
	CALL       _Lcd_Init+0
;cfinal.c,313 :: 		Lcd_Cmd(_LCD_CLEAR); // clear
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;cfinal.c,314 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // if i dont write this it is seen like cloudy
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;cfinal.c,315 :: 		UBRR0L = 0x40; // baud rate = fclock/(16*UBRR) -1 for async mode, normal speed
	LDI        R27, 64
	OUT        UBRR0L+0, R27
;cfinal.c,316 :: 		UBRR0H = 0;    // UBRR = 10^7/(9600*16)-1
	LDI        R27, 0
	STS        UBRR0H+0, R27
;cfinal.c,318 :: 		TCCR0 |= (1 << CS02) | (1 << CS00) | (1 << WGM00) | (1 << COM01); //prescale 1024 normal mode , pwm connect
	IN         R16, TCCR0+0
	ORI        R16, 101
	OUT        TCCR0+0, R16
;cfinal.c,320 :: 		OCR0 = fan_speed * 2.55;
	LDS        R16, _fan_speed+0
	LDS        R17, _fan_speed+1
	LDI        R18, 0
	MOV        R19, R18
	CALL       _float_ulong2fp+0
	LDI        R20, 51
	LDI        R21, 51
	LDI        R22, 35
	LDI        R23, 64
	CALL       _float_fpmul1+0
	CALL       _float_fpint+0
	OUT        OCR0+0, R16
;cfinal.c,321 :: 		TCCR2 |= 1 << CS22; //presecaler 128, normal mode
	IN         R16, TCCR2+0
	ORI        R16, 4
	OUT        TCCR2+0, R16
;cfinal.c,322 :: 		ADCSRA = 0xEF; // prescelar 64 ,no ADIF and ADPS0, free run mode
	LDI        R27, 239
	OUT        ADCSRA+0, R27
;cfinal.c,323 :: 		}
L_end_initialize_ports_and_registers:
	POP        R2
	RET
; end of _initialize_ports_and_registers

_enable_interrupt:

;cfinal.c,327 :: 		void enable_interrupt(){//enable interrupt
;cfinal.c,328 :: 		SREG_I_bit = 1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;cfinal.c,329 :: 		}
L_end_enable_interrupt:
	RET
; end of _enable_interrupt

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;cfinal.c,331 :: 		void main() {
;cfinal.c,332 :: 		initialize_ports_and_registers(); //call function
	PUSH       R2
	PUSH       R3
	CALL       _initialize_ports_and_registers+0
;cfinal.c,333 :: 		enable_interrupt(); // call function
	CALL       _enable_interrupt+0
;cfinal.c,334 :: 		send_string("Enter S for % fan speed and T for temperature:"); // send this to Terminal for 1 time
	LDI        R27, #lo_addr(?lstr27_cfinal+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr27_cfinal+0)
	MOV        R3, R27
	CALL       _send_string+0
;cfinal.c,335 :: 		while(1) {
L_main52:
;cfinal.c,337 :: 		if(sum_twos >= 0x92) { // if it reaches 2 second restart
	LDS        R16, _sum_twos+0
	LDS        R17, _sum_twos+1
	CPI        R17, 0
	BRNE       L__main127
	CPI        R16, 146
L__main127:
	BRSH       L__main128
	JMP        L_main54
L__main128:
;cfinal.c,338 :: 		restart_timer();
	CALL       _restart_timer+0
;cfinal.c,339 :: 		}
L_main54:
;cfinal.c,340 :: 		}
	JMP        L_main52
;cfinal.c,341 :: 		}
L_end_main:
	POP        R3
	POP        R2
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
