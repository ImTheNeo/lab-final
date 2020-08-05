#line 1 "C:/Users/asus/Documents/2256006/Micro/my_labs/2256006-CNG336-LabFinal/2256006_final_c/cfinal.c"
sbit LCD_RS at PORTB2_bit;
sbit LCD_EN at PORTB5_bit;
sbit LCD_D4 at PORTC4_bit;
sbit LCD_D5 at PORTC5_bit;
sbit LCD_D6 at PORTC6_bit;
sbit LCD_D7 at PORTC7_bit;
sbit LCD_RS_Direction at DDB2_bit;
sbit LCD_EN_Direction at DDB5_bit;
sbit LCD_D4_Direction at DDC4_bit;
sbit LCD_D5_Direction at DDC5_bit;
sbit LCD_D6_Direction at DDC6_bit;
sbit LCD_D7_Direction at DDC7_bit;


void send_char(unsigned char my_char){

 while (!((UCSR0A) & (1 << (UDRE0))));
 UDR0 = my_char;
 }

void send_string(unsigned char* my_string){

 while(*my_string)
 send_char(*my_string++);
 }

unsigned char* my_data = 0x500;
void clear_every_thing(unsigned char* my_data, unsigned int ADDR)
 {
 int i = 0;
 memset(my_data, 0, 0x50);
 my_data = ADDR;
 }

unsigned char* int_to_String(unsigned int x) {
 unsigned char converted[4]="";
 unsigned int initial_value = x;
 char temp_val;

 if(initial_value==100){
 return "100";
 }
 if(initial_value==0){
 return "0";
 }
 if(initial_value==1){
 return "1";
 }
 if(initial_value==2){
 return "2";
 }
 if(initial_value==3){
 return "3";
 }
 if(initial_value==4){
 return "4";
 }
 if(initial_value==5){
 return "5";
 }
 if(initial_value==6){
 return "6";
 }
 if(initial_value==7){
 return "7";
 }
 if(initial_value==8){
 return "8";
 }
 if(initial_value==9){
 return "9";
 }
 if(x==0)
 {
 *converted = '0';
 *(converted + 1) = '\0';
 return "";
 }
 else
 {
 unsigned int i = 0;
 while(x)
 {
 unsigned char d = x % 10;
 x /= 10;
 if(d>9)
 converted[i++]=(d + 55);
 else
 converted[i++]=(d + 48);
 }

 converted[i] = '\0';


 temp_val = converted[0];
 converted[0] = converted[1];
 converted[1] = temp_val;


 return converted;
 }
}

 unsigned char waves = 0;
 void start_noise() iv 0x001E{

 PORTB.B4 = waves ^ 1;

 }

unsigned int sum_twos = 0;
 void stop_noise() iv 0x0014
 {++sum_twos;

 }

unsigned char temp;
int my_flag;
unsigned char text_for_usart[0x50];
unsigned char temp_for_usart[4];
unsigned int unit_select;
unsigned int fan_speed = 0;
unsigned int heat_value = 0;
void usart() iv 0x0024{
 unsigned int enter = 0;
 temp = UDR0;


 if(temp == '\n' || temp == '\r')
 enter = 1;
 else
 {if((unsigned int) my_data < 0x530) {
 *my_data++ = temp;
 *my_data = '\0';}
 }
 UDR0 = temp;


 if(enter)
 {my_data = 0x500;

 my_flag=1;

 if(!(strcmp(my_data,"T"))){
 unit_select=1;
 strcpy(text_for_usart, "TEMPERATURE: ");
 strcpy(temp_for_usart,int_to_String(heat_value));
 strcpy(text_for_usart + strlen("TEMPERATURE: "), temp_for_usart);


 }
 else if(!(strcmp(my_data,"S"))){
 unit_select=2;
 strcpy(text_for_usart, "FAN SPEED: ");
 strcpy(temp_for_usart,int_to_String(fan_speed));
 strcpy(text_for_usart + strlen("FAN SPEED: "), temp_for_usart);


 }
 else{

 send_string("Wrong input entered, Please ");
 my_flag=0;
 }
 if(my_flag==1){
 if(unit_select==1)
 strcpy(text_for_usart + strlen("TEMPERATURE: ") + strlen(temp_for_usart), "C\r");

 if(unit_select==2)
 strcpy(text_for_usart + strlen("FAN SPEED: ") + strlen(temp_for_usart), "%\r");

 send_string(text_for_usart);
 }



 clear_every_thing(my_data, 0x500);
 send_string("Enter S for % fan speed and T for temperature:");



 }
 enter = 0;


 }

void active_switches();
unsigned char len_temperature;
unsigned char* lcd_up = 0x300;
unsigned char* lcd_down = 0x320;
unsigned char buzzer_1 = 0;
unsigned char buzzer_2 = 0;
unsigned char motor = 0;
unsigned int second_adc = 0;
unsigned char my_led = 0;
unsigned int first_adc = 0;
void all_calculations() iv 0x002A
 {
 second_adc = ADCL;
 second_adc += (ADCH & 0x03) << 8;
 if(first_adc != second_adc)
 {first_adc = second_adc;

 heat_value = (second_adc * 0.098);
 if(heat_value < 30)
 {
 buzzer_2 = 0;
 fan_speed = 0;
 if(motor)
 {
 ((TIMSK) &= ~(1 << (OCIE0)));
 waves = 0;
 PORTB.B4 = 0;
 motor = 0;
 }
 if(buzzer_1)
 {((TIMSK) &= ~(1 << (TOIE2)));
 TCNT2 = 0;
 buzzer_1 = 0;
 }
 }
 else
 {
 fan_speed = 100*(heat_value-30)/70;
 if(!motor)
 TIMSK |= 1 << (OCIE0);
 motor = 1;
 }

 OCR0 = (fan_speed * 255) / 100;
 strcpy(lcd_up, "TEMPERATURE:");
 strcpy(temp_for_usart,int_to_String(heat_value));
 strcpy(lcd_up + 12, temp_for_usart);
 len_temperature = strlen(temp_for_usart);
 lcd_up[12 + len_temperature] = 'C';
 memset(lcd_up + 13 + len_temperature, ' ', 11 - len_temperature);
 strcpy(lcd_down, "FAN SPEED:");
 strcpy(temp_for_usart,int_to_String(fan_speed));
 strcpy(lcd_down + 10, temp_for_usart);
 len_temperature = strlen(temp_for_usart);
 lcd_down[10 + strlen(temp_for_usart)] = '%';
 memset(lcd_down + 11 + len_temperature, ' ', 11 - len_temperature);
 my_led = ((1 << (second_adc / 127)) - 1) & 0xFF;
 }

 active_switches();
}
void active_switches(){
 if(PIND.B0==1)
 Lcd_Out(1, 1, lcd_up);
 else
 {unsigned char temp[0x10];

 memset(temp, ' ', 0x10);
 Lcd_Out(1, 1, temp);}

 if(PIND.B1==1)
 Lcd_Out(2, 1, lcd_down);
 else
 {unsigned char temp[0x10];

 memset(temp, ' ', 0x10);
 Lcd_Out(2, 1, temp);}

 if(PIND.B2==0)
 {
 buzzer_2 = 0;
 if(buzzer_1)
 {((TIMSK) &= ~(1 << (TOIE2)));
 TCNT2 = 0;
 ((PORTC) |= (1 << (1)));
 buzzer_1 = 0;}}
 else if(!buzzer_1 && heat_value > 30 && !buzzer_2)
 {((TIMSK) |= (1 << (TOIE2)));
 ((PORTC) &= ~(1 << (1)));
 buzzer_1 = 1;
 buzzer_2 = 1;}


 if(PIND.B3==0)
 PORTA = 0;

 else
 PORTA = my_led;
}
void restart_timer(){
 sum_twos = 0;
 TIMSK &= ~(1 << TOIE2);
 TCNT2 = 0;
 PORTC |= 1 << 1;
 buzzer_1 = 0;
}

void initialize_ports_and_registers(){

 DDRA = 0xFF;

 DDRC = 0x02;

 DDRD = 0xF0;

 UCSR0C |= (1 << UCSZ01)|(1 << UCSZ00);

 UCSR0B |= (1 << RXEN0)| (1 << RXCIE0) | (1 <<TXEN0) ;


 DDRB |= 1 << 4;
 PORTD &= ~(1 << (7));
 PORTD |= 1 << 6;
 PORTC |= 1 << 1;
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 UBRR0L = 0x40;
 UBRR0H = 0;

 TCCR0 |= (1 << CS02) | (1 << CS00) | (1 << WGM00) | (1 << COM01);

 OCR0 = fan_speed * 2.55;
 TCCR2 |= 1 << CS22;
 ADCSRA = 0xEF;
}



void enable_interrupt(){
 SREG_I_bit = 1;
}

void main() {
 initialize_ports_and_registers();
 enable_interrupt();
 send_string("Enter S for % fan speed and T for temperature:");
 while(1) {

 if(sum_twos >= 0x92) {
 restart_timer();
 }
 }
}
